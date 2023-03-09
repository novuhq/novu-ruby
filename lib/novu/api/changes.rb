# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Changes provides an API for managing changes in the Novu application.
    #
    # This module includes methods for retrieving, count, and applying bulk changes.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Changes), see https://docs.novu.co/api/get-changes/.
    module Changes
      # Returns a list of changes that can be paginated using the `page` query parameter
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination.
      # @param `limit` [Integer(optional)]
      # @param `promoted` [String]
      #
      # @return [Hash] The list of changes that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def changes(query = {})
        get("/changes", query: query)
      end

      # Returns changes count
      #
      # @return [Hash] changes count
      # @return [number] status
      #  - Returns 200 if successful
      def count_changes
        get("/changes/count")
      end

      # Apply Bulk Change
      #
      # @return [Hash] updated change.
      # @return [number] status
      #  - Returns 201 if the bulk change has been updated correctly.
      def apply_bulk_changes
        post("/changes/bulk/apply")
      end

      # Apply change
      #
      # @pathparams:
      # @param `change_id` [Integer] The ID of the change to update.
      #
      # @return [Hash] updated change.
      # @return [number] status
      #  - Returns 201 if the change with the change_id provided has been updated correctly.
      def apply_change(change_id)
        post("/changes/#{change_id}/apply")
      end
    end
  end
end
