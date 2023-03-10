# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Notification provides an API for managing Notification in the Novu application.
    #
    # This module includes methods for retrieving notifications, notifications stats and notifications graph stats.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Notification), see https://docs.novu.co/api/.
    module Notification
      # Returns a list of notifications that can be paginated using the `page` query parameter and
      # filtered by the environment where it is executed from the organization the user belongs to.
      #
      # @queryparams:
      # @param `channels` [Array[String]] Available values : in_app, email, sms, chat, push
      # @param `templates` [Array[String]]
      # @param `emails` [Array[String]]
      # @param `search` [String(optional)]
      # @param `transactionId` [String(optional)]
      # @param `page` [Integer(optional)] Number of page for the pagination. Default value is 0
      #
      # @return [Hash] The list of notification that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful.
      def notifications(query = {})
        get("/notifications", :query)
      end

      # Returns a list of notifications stats
      #
      # @return [Hash] notification stats.
      # @return [number] status
      #  - Returns 200 if successful.
      def notifications_stats
        get("/notifications/stats")
      end

      # Returns a list of notifications stats
      #
      # @queryparams:
      # @param `days` [Integer]
      #
      # @return [Hash] notification graph stats.
      # @return [number] status
      #  - Returns 200 if successful.
      def notifications_graph_stats(query = {})
        get("/notifications/graph/stats", query: query)
      end

      # Returns a notification
      #
      # @pathparams:
      # @param `notification_id` [String]
      #
      # @return [Hash] notification entity
      # @return [number] status
      #  - Returns 200 if successful.
      def notification(notification_id)
        get("/notifications/#{notification_id}")
      end
    end
  end
end
