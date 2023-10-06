# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Subscribers provides an API for managing subscribers in the Novu application.
    #
    # This module includes methods for creating, retrieving, updating, and deleting subscribers.
    # It also includes methods for updating subscriber credentials, online status, preferences etc.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Subscribers), see https://docs.novu.co/api/get-subscribers/.
    module Subscribers
      # Returns a list of subscribers, could paginated using the `page` query parameter
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination. The page to fetch, defaults to 0.
      #
      # @return [Hash] The list of subscribers that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def subscribers(query = {})
        get("/subscribers", query: query)
      end

      # Creates a subscriber entity, in the Novu platform.
      # The subscriber will be later used to receive notifications, and access notification feeds.
      # Communication credentials such as email, phone number, and 3 rd party credentials
      # i.e slack tokens could be later associated to this entity.
      #
      # @bodyparams:
      # @param `subscriberId` [String] The internal identifier you used to create this subscriber, usually correlates to the id the user in your systems.
      # @param `email` [String(optional)]
      # @param `firstName` [String(optional)]
      # @param `lastName` [String(optional)]
      # @param `phone` [String(optional)]
      # @param `avatar` [String(optional)] An http url to the profile image of your subscriber
      # @param `locale` [String(optional)]
      # @param `data` [Hash(optional)]
      #
      # @return [Hash] The hash of subscriber data is successfully returned.
      # @return [number] status - The status code. Returns 201 if the susbscriber has been successfully created.
      def create_subscriber(body)
        post("/subscribers", body: body)
      end

      # Retrieves the subscriber with the given ID.
      #
      # @pathparams
      # @param `subscriber_id` [String] The ID of the subscriber to retrieve.
      #
      # @return [Hash] The retrieved subscriber.
      # @return [number] status
      #  - Returns 200 if the subscriber with the subscriber_id provided exists in the database.
      def subscriber(subscriber_id)
        get("/subscribers/#{subscriber_id}")
      end

      # Used to update the subscriber entity with new information
      #
      # @pathparams:
      # @param `subscriber_id` [String] The ID of the subscriber to update.
      #
      # @bodyparams
      # @param `email` [String(optional)]
      # @param `firstName` [String(optional)]
      # @param `lastName` [String(optional)]
      # @param `phone` [String(optional)]
      # @param `avatar` [String(optional)]
      # @param `locale` [String(optional)]
      # @param `data` [String(optional)]
      #
      # @return [Hash] The updated subscriber entity.
      # @return [number] status
      #  - Returns 200 if the subscriber with the subscriber_id provided has been updated correctly.
      def update_subscriber(subscriber_id, body)
        put("/subscribers/#{subscriber_id}", body: body)
      end

      # Deletes a subscriber entity from the Novu platform
      #
      # @pathparams:
      # @param `subscriber_id` [String] The ID of the subscriber to delete.
      #
      # @return [Hash] Hash of acknowledged and status.
      # @return [number] status
      #  - Returns 200 if the subscriber has been deleted correctly.
      def delete_subscriber(subscriber_id)
        delete("/subscribers/#{subscriber_id}")
      end

      # Update subscriber credentials from the Novu platform. Subscriber credentials associated to the delivery methods such as slack and push tokens.
      #
      # @pathparams:
      # @param `subscriber_id` [String] The ID of the subscriber to update credentials.
      #
      # @bodyparams:
      # @param `providerId` [String] The provider identifier for the credentials
      # @param `credentials` [Hash] Credentials payload for the specified provider
      #
      # @return [Hash] Hash of updated subscriber credentials entity
      # @return [number] status
      #  - Returns 200 if the subscriber credentials has been updated correctly.
      def update_subscriber_credentials(subscriber_id, body)
        put("/subscribers/#{subscriber_id}/credentials", body: body)
      end

      # Delete subscriber credentials by providerId
      # Delete subscriber credentials such as slack and expo tokens.
      #
      # @pathParams:
      # @param `subscriberId` [String] The ID of the subscriber to update credentials.
      # @param `providerId` [String] The provider identifier for the credentials
      #
      # @return [number] status
      #  - Returns 204 if the subscriber credentials has been deleted successfully.
      def delete_subscriber_credentials(subscriberId, providerId)
        delete("/subscribers/#{subscriberId}/credentials/#{providerId}")
      end

      # Used to update the subscriber isOnline flag.
      #
      # @pathparams:
      # @param `subscriber_id` [String] The ID of the subscriber to update online status.
      #
      # @bodyparams:
      # @param `isOnline` [Boolean]
      #
      # @return [Hash] The updated subscriber entity.
      # @return [number] status
      #  - Returns 200 if the subscriber online status has been updated correctly.
      def update_subscriber_online_status(subscriber_id, body)
        patch("/subscribers/#{subscriber_id}/online-status", body: body)
      end

      # Used to get the subscriber preference
      #
      # @pathparams:
      # @param `subscriber_id` [String] The ID of the subscriber.
      #
      # @return [Hash] Hash of template and preference.
      # @return [number] status
      #  - Returns 200 if the subscriber preference has been retrieved successfully.
      def subscriber_preferences(subscriber_id)
        get("/subscribers/#{subscriber_id}/preferences")
      end

      # Used to update the subscriber preference
      #
      # @pathparams:
      # @param `subscriber_id` [String] The ID of the subscriber to update preference.
      # @param `template_id` [String] The ID of the template to update preference.
      #
      # @bodyparams:
      # @param `channel` [Hash(optional)] The subscriber preferences for every ChannelTypeEnum for the notification template assigned.
      # @param `enabled` [Boolean(optional)] Sets if the notification template is fully enabled for all channels or not for the subscriber.
      #
      # @return [Hash] Hash of template and preference.
      # @return [number] status
      #  - Returns 200 if the subscriber preference has been updated correctly.
      def update_subscriber_preference(subscriber_id, template_id, body)
        patch("/subscribers/#{subscriber_id}/preferences/#{template_id}", body: body)
      end

      # Returns a notification feed for a particular subscriber
      #
      # @pathparams
      # @param `subscriber_id` [String]
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination.
      # @param `feedIdentifier` [String]
      # @param `seen` [Boolean(optional)]
      #
      # @return [Hash] List of notification feed of a subscriber that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def subscriber_notification_feed(subscriber_id, query = {})
        get("/subscribers/#{subscriber_id}/notifications/feed", query: query)
      end

      # Returns the unseen notification count for subscribers feed
      #
      # @pathparams
      # @param `subscriber_id` [String]
      #
      # @queryparams:
      # @param `seen` [Boolean]
      #
      # @return [Hash] the unseen notification count
      # @return [number] status
      #  - Returns 200 if successful
      def subscriber_unseen_notification_count(subscriber_id, query = {})
        get("/subscribers/#{subscriber_id}/notifications/unseen", query: query)
      end

      # Mark a subscriber feed message as seen
      #
      # @pathparams
      # @param `subscriber_id` [String]
      #
      # @bodyparams:
      # @param `messageId` [Hash]
      # @param `mark` [Hash]
      #
      # @return [Hash] the unseen notification count
      # @return [number] status
      #  - Returns 201 if successful
      def mark_subscriber_feed_seen(subscriber_id, body)
        post("/subscribers/#{subscriber_id}/messages/markAs", body: body)
      end

      # Mark message action as seen
      #
      # @pathparams
      # @param `message_id` [String]
      # @param `type` [String]
      # @param `subscriber_id` [String]
      #
      # @return [Hash] the unseen notification count
      # @return [number] status
      #  - Returns 201 if successful
      def mark_message_action_seen(subscriber_id, message_id, type)
        post("/subscribers/#{subscriber_id}/messages/#{message_id}/actions/#{type}")
      end

      # Marks all the subscriber messages as read, unread, seen or unseen.
      # 
      # @pathparams
      # @param `subscriber_id` [String]
      # 
      # @bodyParams:
      # @param `markAs` [String] The type of action to perform either read, unread, seen or unseen.
      # @param `feedIdentifier` [String|Array(Optional)]  The feed id (or array) to mark messages of a particular feed.
      #
      # @return [number] status
      #  - Returns 201 if successful
      def mark_all_subscriber_messages(subscriber_id, body)
        post("/subscribers/#{subscriber_id}/messages/mark-all", body: body)
      end

      # Handle providers OAUTH redirect
      #
      # @pathparams:
      # @param `subscriberId` [String]
      # @param `providerId` [String]
      #
      # @queryparams:
      # @param `code` [String]
      # @param `hmacHash` [String]
      # @param `environmentId` [String]
      # @param `integrationIdentifier` [String]
      #
      # @return [Hash] The list of changes that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def provider_oauth_redirect(subscriberId, providerId, query = {})
        get("/subscribers/#{subscriberId}/credentials/#{providerId}/oauth/callback", query: query)
      end

      # Handle chat OAUTH
      #
      # @pathparams:
      # @param `subscriberId` [String]
      # @param `providerId` [String]
      #
      # @queryparams:
      # @param `hmacHash` [String]
      # @param `environmentId` [String]
      # @param `integrationIdentifier` [String]
      #
      # @return [number] status
      #  - Returns 200 if successful
      def chat_oauth(subscriberId, providerId, query = {})
        get("/subscribers/#{subscriberId}/credentials/#{providerId}/oauth", query: query)
      end
    end
  end
end
