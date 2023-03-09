# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Environments provides an API for managing environments in the Novu application.
    #
    # This module includes methods for creating, retrieving, and updating environments.
    # It also includes methods for getting and regenerating the api keys also for updatation of widget settings .
    #
    # For more information on the Novu API(https://api.novu.co/api#/Environments), see https://docs.novu.co/api/get-current-environment/.
    module Environments
      # Retrieves the current environment
      #
      # @return [Hash] The retrieved environment.
      # @return [number] status
      #  - Returns 200 if successful
      def current_environment
        get("/environments/me")
      end

      # Creates a new environment.
      #
      # @bodyparams:
      # @param `name` [String]
      # @param `parentId` [String(optional)]
      #
      # @return [Hash]  The created environment entity.
      # @return [number] status - The status code. Returns 201 if the environment has been successfully created.
      def create_environment(body)
        post("/environments", body: body)
      end

      # Returns a list of environments
      #
      # @return [Hash] The list of environments.
      # @return [number] status
      #  - Returns 200 if successful
      def environments
        get("/environments")
      end

      # Update the environment.
      #
      # @pathparams:
      # @param `environment_id` [String] The ID of the environment to update.
      #
      # @bodyparams
      # @param `name` [String(optional)]
      # @param `identifier` [String(optional)]
      # @param `parentId` [String(optional)]
      # @param `dns` [Hash]
      #
      # @return [Hash] The updated environment.
      # @return [number] status
      #  - Returns 200 if the environment with the environment_id provided has been updated correctly.
      def update_environment(environment_id, body)
        put("/environments/#{environment_id}", body: body)
      end

      # Returns a list of api keys
      #
      # @return [Hash] The list of api keys.
      # @return [number] status
      #  - Returns 200 if successful
      def api_keys
        get("/environments/api-keys")
      end

      # Return regenerated api keys
      #
      # @return [Hash] Api keys.
      # @return [number] status
      #  - Returns 200 if successful
      def regenerate_api_keys
        post("/environments/api-keys/regenerate")
      end

      # Update the widget settings.
      #
      # @bodyparams
      # @param `notificationCenterEncryption` [Boolean]
      #
      # @return [Hash] The updated environment entity.
      # @return [number] status
      #  - Returns 200 if the environment entity updated.
      def update_widget_settings(body)
        put("/environments/widget/settings", body: body)
      end
    end
  end
end
