# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Integrations provides an API for managing integrations in the Novu application.
    #
    # This module includes methods for creating, retrieving, updating, and deleting integrations.
    # It also includes methods for retrieving channel limit, in-app status, webhook provider status.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Integrations), see https://docs.novu.co/api/get-integrations/.
    module Integrations
      # Returns a list of integrations
      #
      # @return [Hash] The list of integrations.
      # @return [number] status
      #  - Returns 200 if successful
      def integrations
        get("/integrations")
      end

      # Creates a new intgration.
      #
      # @bodyparams:
      # @param `providerId` [String]
      # @param `channel` [String]
      # @param `credentials` [Hash]
      # @param `active` [Boolean]
      # @param `check` [Boolean]
      #
      # @return [Hash] The created integration entity.
      # @return [number] status - The status code. Returns 201 if the intgration has been successfully created.
      def create_integration(body)
        post("/integrations", body: body)
      end

      # Returns a list of active integrations
      #
      # @return [Hash] The list of active integrations.
      # @return [number] status
      #  - Returns 200 if successful
      def active_integrations
        get("/integrations/active")
      end

      # Returns a list of integrations
      #
      # @pathparams
      # @param `provider_id` [String]
      #
      # @return [number] status
      #  - Returns 200 if successful
      def webhook_provider_status(provider_id)
        get("/integrations/webhook/provider/#{provider_id}/status")
      end

      # Update the credentials of a integration.
      #
      # @pathparams:
      # @param `integration_id` [Integer] The ID of the integration to update.
      #
      # @bodyparams
      # @param `active` [Boolean]
      # @param `credentials` [Hash]
      # @param `check` [Boolean]
      #
      # @return [Hash] The updated intgration.
      # @return [number] status
      #  - Returns 200 if the integration with the integrationId provided has been updated correctly.
      def update_integration(integration_id, body)
        put("/integrations/#{integration_id}", body: body)
      end

      # Execute a soft delete of a integration given a certain ID.
      #
      # @pathparams:
      # @param `integration_id` [Integer] The ID of the integration to delete.
      #
      # @return [Hash] The retrieved integration.
      # @return [number] status
      #  - Returns 200 if the integration has been deleted correctly.
      def delete_integration(integration_id)
        delete("/integrations/#{integration_id}")
      end

      # Returns a channel limit
      #
      # @pathparams
      # @param `channel_type` [String]
      #
      # @return [number] status
      #  - Returns 200 if successful
      def channel_limit(channel_type)
        get("/integrations/#{channel_type}/limit")
      end

      # Returns in-app status
      #
      # @return [number] status
      #  - Returns 200 if successful
      def in_app_status
        get("/integrations/in-app/status")
      end
    end
  end
end
