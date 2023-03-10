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

    base_uri "https://api.novu.co/v1"
    format :json

    def initialize(access_token = nil)
      @access_token = access_token
      self.class.default_options.merge!(headers: { "Authorization" => "ApiKey #{access_token}" })
    end
  end
end
