#!/usr/bin/ruby

require 'net/http'
require 'couchdb.class.rb'
require 'entry.class.rb'
require 'json'

# Constants
$host = "localhost"
$port = "5984"
$database = "test"

# Example raw input data
# hyfi     pts/11       nomad.ccs.neu.ed Fri Feb  8 18:32:59 2013   still logged in
# hyfi     pts/0        c-24-62-61-212.h Fri Feb  8 01:54:57 2013 - Fri Feb  8 04:33:51 2013  (02:38)

lines = `last`.split(/\n/)
server = CouchDB.new($host,$port)
lines.each do |line|
  tmp = Entry.new(line)
  server.post("/"+$database, tmp.to_json)
end
