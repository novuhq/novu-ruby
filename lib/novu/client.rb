# frozen_string_literal: true

require "novu/api/notification"
require "novu/api/connection"
require "novu/api/events"
require "novu/api/integrations"
require "novu/api/layouts"
require "novu/api/notification_templates"
require "novu/api/subscribers"
require "novu/api/topics"

module Novu
  class Client
    include HTTParty
    include Novu::Api::Connection
    include Novu::Api::Events
    include Novu::Api::Integrations
    include Novu::Api::Layouts
    include Novu::Api::NotificationTemplates
    include Novu::Api::Notification
    include Novu::Api::Subscribers
    include Novu::Api::Topics

    base_uri "https://api.novu.co/v1"
    format :json

    def initialize(access_token = nil)
      @access_token = access_token
      self.class.default_options.merge!(headers: { "Authorization" => "ApiKey #{access_token}" })
    end
  end
end
