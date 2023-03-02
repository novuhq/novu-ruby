require 'pry'
require "novu/api/notification"
require "novu/api/connection"

module Novu
  class Client
    include HTTParty
    include Novu::Api::Notification
    include Novu::Api::Connection
    
    base_uri "https://api.novu.co/v1"
    format :json
   
    # include GrooveHQ::Client::Connection


    def initialize(access_token = nil)
      @access_token = access_token || ENV["NOVU_ACCESS_TOKEN"]
      self.class.default_options.merge!(headers: { "Authorization" => "ApiKey #{access_token}" })
    end


    # for debugging purpose only
    # def perform_request(path)
    #   url = "/#{path}"
    #   binding.pry
    #   response = self.class.get(url, headers: { "Authorization" => "ApiKey #{@access_token}" })
    #   JSON.parse(response.body)
    # end

    # require "./lib/novu.rb"
    # client = Novu::Client.new("aeaf31aa1834b3a317dcf6970d028dae")
    # client.perform_request("notification-templates")

  end
end
