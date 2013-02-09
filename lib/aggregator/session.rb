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

  end
end

