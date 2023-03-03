# frozen_string_literal: true

require "pry"
require "novu/api/notification"
require "novu/api/connection"
require "novu/api/events"
require "novu/api/subscribers"

module Novu
  class Client
    include HTTParty
    include Novu::Api::Connection
    include Novu::Api::Events
    include Novu::Api::Notification
    include Novu::Api::Subscribers

    base_uri "https://api.novu.co/v1"
    format :json

    def initialize(access_token = nil)
      @access_token = access_token
      self.class.default_options.merge!(headers: { "Authorization" => "ApiKey #{access_token}" })
    end
  end
end
