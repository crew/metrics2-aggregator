require 'rubygems'
require 'couchrest'
require 'json'

class Session
  attr_accessor :user, :start, :stop, :length

  def initialize(user, start, stop, length)
    @user = user
    @start = start
    @stop = stop
    @length = length
  end

  def to_hash
    hash = {}
    instance_variables.each do |v|
      hash[v.to_s.delete("@")] = instance_variable_get(v)
    end
    hash
  end

  def to_json
    self.to_hash.to_json
  end
end

#while true do
  # Get all logged in users
  sessions = `last | grep "still logged in"`.split("\n")
  sessions.each do |session|
    tmp =  session.split
    p tmp
  end
#end
