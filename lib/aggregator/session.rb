# Represents an entry in the raw log database
module Aggregator
  class Session
    attr_accessor :user, :machine, :os, :source, :ip, :started,
      :ended, :set

    def initialize(user, machine, os, source, ip, started, ended, set)
      @user = user
      @machine = machine
      @os = os
      @source = source
      @ip = ip
      @started = started
      @ended = ended
      @set = set
    end

    def to_hash
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@").intern] = instance_variable_get(var) }
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

