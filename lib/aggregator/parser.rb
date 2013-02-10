module Aggregator
  class Parser
    # parse_list_line : String Symbol Symbol Timestamp -> Session
    # Parses a line from the `last -Fw` command
    # hostname -> hostname of the machine `last` was run on
    # os -> the OS running on the machine (:linux or :windows)
    # set -> the set this session is a part of
    def self.parse_last_line(line, hostname, os, set)
      # Example raw input data
      # hyfi     pts/11       nomad.ccs.neu.ed Fri Feb  8 18:32:59 2013   still logged in
      # hyfi     pts/0        c-24-62-61-212.h Fri Feb  8 01:54:57 2013 - Fri Feb  8 04:33:51 2013  (02:38)

      line = line.strip.split

      # Normalize the data
      line.insert(2, nil) if line[1].include? 'tty'

      if line[-3, 3].join(' ') == 'still logged in'
        line.pop(3)
        line << nil
      else
        line.pop
        tmp = Time.from_asctime(line.pop(5).join(' '))
        line.pop
        line << tmp
      end

      line.insert(-2, Time.from_asctime(line.slice!(-6, 5).join(' ')))

      source = line[1].include?('tty') ? :tty : :pts
      started = line[3]
      ended = line[4]

      Session.new(hostname, os, source, started, ended, set)
    end
  end

  # get_windows_log : String Time -> Array of Sessions
  # Given the contents of a Windows log file (as a string),
  # and the Time for that dataset, returns a bunch of sessions
  def get_windows_log(logs, set)
    # Example raw input data:
    # ["SQUIRTLE:logout:CCIS-WINDOWS:1360267971",
    #  "SQUIRTLE:login:CCIS-WINDOWS:1360267859"...]

    entries = {}
    logs.split("\n").each { |line|
      line = line.strip.split(':')
      hostname = line[0].downcase.intern
      entries[hostname] ||= []
      entries[hostname] << {
        hostname: hostname,
        event: line[1].intern,
        os: :windows,
        time: Time.at(line[3].to_i)
      }
    }

    results = []

    # Match login/logout events
    entries.each do |hostname, events|
      until events.empty?
        result = {}
        cursor = events.delete_at(0)
        if cursor[:event] == :logout
          # Got a logout! Go find the login
          result[:logout] = cursor
          i = events.index { |e| e[:event] == :login }
          result[:login] = i ? events.delete_at(i) : nil
        else
          # Still logged in
          result[:login] = cursor
          result[:logout] = nil
        end
        login = result[:login][:time] if result[:login]
        logout = result[:logout][:time] if result[:logout]
        session = Aggregator::Session.new(hostname, :windows, :tty, login, logout, set)
        results << session if login
      end
    end

    results
  end
end
