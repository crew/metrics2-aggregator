#!/usr/bin/ruby

require 'net/http'

# Example raw input data
# hyfi     pts/11       nomad.ccs.neu.ed Fri Feb  8 18:32:59 2013   still logged in
# hyfi     pts/0        c-24-62-61-212.h Fri Feb  8 01:54:57 2013 - Fri Feb  8 04:33:51 2013  (02:38)

class Entry
  def initialize(line)
    @raw = line
  end

  def print
    puts @raw
  end
end

# Class for basic couchdb functionality
class CouchDB
  # Set up this instance
  def initialize(host, port)
    @host = host
    @port = port
  end

  # Make http request
  def request(req)
    res = Net::HTTP.start(@host,@port) do |http|
       http.request(req)
    end
    res
  end

  # Delete the database
  def delete(uri)
    request(Net::HTTP::Delete.new(uri))
  end

  def get(uri)
    request(Net::HTTP::Get.new(uri))
  end

  def post(uri, json)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req.body = json
    request(req)
  end

end




lines = `last`.split(/\n/)

lines.each do |line|
  tmp = Entry.new(line)
end
