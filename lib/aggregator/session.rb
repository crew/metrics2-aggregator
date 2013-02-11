# Represents an entry in the raw log database
module Aggregator
  class Session
    attr_accessor :machine, :os, :source, :started, :ended, :set

    def initialize(hostname, os, source, started, ended, set)
      @hostname = hostname  # machine hostname
      @os = os              # linux or windows
      @source = source      # tty or pts
      @started = started    # when the session was started
      @ended = ended        # when the session ended
      @set = set            # the timestamp for when this data was grabbed
      instance_variables.map {|var| var.lowercase! if var.is_a? String }
    end

    def to_hash
      hash = {}
      instance_variables.each do |var|
        hash[var.to_s.delete("@").intern] = instance_variable_get(var)
      end
      hash
    end

    def to_json
      hash = self.to_hash
      # Unix timestamps
      hash[:started] = hash[:started].to_i
      hash[:ended] = hash[:ended].to_i
      hash[:set] = hash[:set].to_i
      hash.to_json
    end

    # should_send? : Time -> Boolean
    # Session should be counted/saved if it started or ended at least
    # ten minutes after the given timestamp
    def should_send?
      ten_minutes_ago = @set - 10*60
      (@ended and @ended >= ten_minutes_ago) or (@started and @started >= ten_minutes_ago)
    end

  end
end

