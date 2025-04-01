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
require "novu/api/organizations"
require "novu/api/subscribers"
require "novu/api/tenants"
require "novu/api/topics"
require "novu/api/workflow_overrides"
require_relative "version"

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
    include Novu::Api::Organizations
    include Novu::Api::Subscribers
    include Novu::Api::Tenants
    include Novu::Api::Topics
    include Novu::Api::WorkflowOverrides

    format :json

    attr_accessor :enable_retry, :max_retries, :initial_delay, :max_delay, :idempotency_key

    # @param `access_token` [String]
    # @param `idempotency_key` [String]
    # @param `enable_retry` [Boolean]
    # @param `retry_config` [Hash]
    #           - max_retries [Integer]
    #           - initial_delay [Integer]
    #           - max_delay [Integer]
    def initialize(access_token: nil, idempotency_key: nil, enable_retry: false, retry_config: {}, backend_url: "https://api.novu.co/v1")
      raise ArgumentError, "Api Key cannot be blank or nil" if access_token.blank?

      @idempotency_key = idempotency_key.blank? ? UUID.new.generate : idempotency_key

      @enable_retry = enable_retry
      @access_token = access_token.to_s.strip
      @retry_attempts = 0

      retry_config = defaults_retry_config.merge(retry_config)
      @max_retries = retry_config[:max_retries]
      @initial_delay = retry_config[:initial_delay]
      @max_delay = retry_config[:max_delay]

      self.class.base_uri(backend_url)

      self.class.default_options.merge!(headers: { 
					"Authorization" => "ApiKey #{@access_token}",
					"User-Agent" => "novu/ruby/#{Novu::VERSION}"
				}
			)

      # Configure the exponential backoff - specifying initial and maximal delays, default is 4s and 60s respectively
      if @enable_retry
        @retry_config = retry_config
        @backoff = ExponentialBackoff.new(@initial_delay, @max_delay)
      end
    rescue ArgumentError => e
      puts "Error initializing Novu client: #{e.message}"
    end

    private 

    # @retun [Hash]
    #   - max_retries [Integer]
    #   - initial_delay [Integer]
    #   - max_delay [Integer]
    def defaults_retry_config
      { max_retries: 1, initial_delay: 4, max_delay: 60 }
    end
  end
end
