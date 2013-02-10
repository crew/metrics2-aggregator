# Class for basic couchdb functionality
module Aggregator
  class CouchDB
    # Set up this instance
    def initialize
      @host = Config::HOST
      @port = Config::PORT
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
      puts json
      req = Net::HTTP::Post.new(uri)
      req["Content-Type"] = "application/json"
      req.body = json
      request(req)
    end
  end
end
