module Aggregator
  class Parser
    # parse_list_line : String Symbol Symbol Timestamp -> Session
    # Parses a line from the `last -Fw` command
    # hostname -> hostname of the machine `last` was run on
    # os -> the OS running on the machine (:linux or :windows)
    # set -> the set this session is a part of
    def self.parse_last_line(line, hostname, os, set)
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
end
