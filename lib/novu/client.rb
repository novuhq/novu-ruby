# frozen_string_literal: true

require "novu/api/blueprints"
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
require "novu/api/tenants"
require "novu/api/topics"

module Novu
  class Client
    include HTTParty
    include Novu::Api::Blueprints
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
    include Novu::Api::Tenants
    include Novu::Api::Topics

    base_uri "https://api.novu.co/v1"
    format :json

    attr_accessor :enable_retry, :max_retries, :initial_delay, :max_delay

    def initialize(access_token: nil, enable_retry: false, retry_config: {} )
      raise ArgumentError, "Api Key cannot be blank or nil" if access_token.blank?

      @enable_retry = enable_retry
      @access_token = access_token.to_s.strip
      @retry_attempts = 0

      retry_config = defaults_retry_config.merge(retry_config)
      @max_retries = retry_config[:max_retries]
      @initial_delay = retry_config[:initial_delay]
      @max_delay = retry_config[:max_delay]

      self.class.default_options.merge!(headers: { "Authorization" => "ApiKey #{@access_token}" })

      # Configure the exponential backoff - specifying initial and maximal delays, default is 4s and 60s respectively
      if @enable_retry
        @retry_config = retry_config
        @backoff = ExponentialBackoff.new(@initial_delay, @max_delay)
      end
    rescue ArgumentError => e
      puts "Error initializing Novu client: #{e.message}"
    end

    private 

    def defaults_retry_config
      { max_retries: 3, initial_delay: 4.0, max_delay: 60.0 }
    end
  end
end
