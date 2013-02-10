$: << File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'helpers/time'
require 'aggregator/couchdb'
require 'aggregator/session'
require 'aggregator/parser'
