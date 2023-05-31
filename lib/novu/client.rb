# frozen_string_literal: true

require "novu/api/changes"
require "novu/api/connection"
require "novu/api/environments"
require "novu/api/events"
require "novu/api/execution_details"
require "novu/api/feeds"
require "novu/api/inbound_parse"
require "novu/api/integrations"
require "novu/api/layouts"
require "novu/api/messages"
require "novu/api/notification_groups"
require "novu/api/notification_templates"
require "novu/api/notification"
require "novu/api/subscribers"
require "novu/api/topics"

module Novu
  class Client
    include HTTParty
    include Novu::Api::Changes
    include Novu::Api::Connection
    include Novu::Api::Environments
    include Novu::Api::Events
    include Novu::Api::ExecutionDetails
    include Novu::Api::Feeds
    include Novu::Api::InboundParse
    include Novu::Api::Integrations
    include Novu::Api::Layouts
    include Novu::Api::Messages
    include Novu::Api::NotificationGroups
    include Novu::Api::NotificationTemplates
    include Novu::Api::Notification
    include Novu::Api::Subscribers
    include Novu::Api::Topics

    DEFAULT_BASE_URI = "https://api.novu.co/v1"

    base_uri DEFAULT_BASE_URI
    format :json

    def initialize(access_token = nil, base_uri = nil)
      raise ArgumentError, "Api Key cannot be blank or nil" if access_token.blank?

      @access_token = access_token.to_s.strip
      self.class.default_options.merge!(headers: { "Authorization" => "ApiKey #{@access_token}" })

      base_uri ||= DEFAULT_BASE_URI
      self.class.base_uri base_uri
    rescue ArgumentError => e
      puts "Error initializing Novu client: #{e.message}"
    end
  end
end
