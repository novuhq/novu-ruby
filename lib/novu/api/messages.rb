# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Messages provides an API for managing messages in the Novu application.
    #
    # This module includes methods for retrieving, and deleting messages.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Messages), see https://docs.novu.co/api/get-messages/.
    module Messages
      # Returns a list of messages that can be paginated using the `page` query parameter and
      # filtered by the environment where it is executed from the organization the user belongs to.
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination. The page to fetch, defaults to 0.
      # @param `limit` [Integer(optional)] The number of messages to fetch, defaults to 10.
      # @param `channel` [String(optional)] The channel for the messages you wish to list.
      # @param `subscriberId` [String(optional)] The subscriberId for the subscriber you like to list messages for.
      #
      # @return [Hash] The list of messages that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def messages(query = {})
        get("/messages", query: query)
      end

      # Deletes a message entity from the Novu platform
      #
      # @pathparams:
      # @param `message_id` [String] The ID of the message to delete.
      #
      # @return [Hash] of acknowledged and status.
      # @return [number] status
      #  - Returns 200 if the message has been deleted correctly.
      def delete_message(message_id)
        delete("/messages/#{message_id}")
      end
    end
  end
end
