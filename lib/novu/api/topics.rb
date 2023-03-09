# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Topics provides an API for managing topics in the Novu application.
    #
    # This module includes methods for creating and retrieving and updating topic.
    # It also includes methods for subscriber addition and removal.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Topics), see https://docs.novu.co/api/topic-creation/.
    module Topics
      # Create a topic
      #
      # @bodyparams:
      # @param `key` [String] User defined custom key and provided by the user that will be an unique identifier for the Topic created.
      # @param `name` [String] User defined custom name and provided by the user that will name the Topic created.
      #
      # @return [number] status - The status code. Returns 201 if the topic has been successfully created.
      def create_topic(body)
        post("/topics", body: body)
      end

      # Returns a list of topics that can be paginated using the `page` query parameter and
      #  filtered by the topic key with the `key` query parameter
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination.
      # @param `pageSize` [Integer(optional)] Size of page for the pagination.
      # @param `key` [String(optional)] Topic key.
      #
      # @return [Hash] The list of topics that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def topics(query = {})
        get("/topics", query: query)
      end

      # Add subscribers to a topic by key
      #
      # @pathparams
      # @param `topic_key` [String]

      # @bodyparams:
      # @param `subscribers` [Array] List of subscriber identifiers that will be associated to the topic
      #
      # @return [number] status - The status code. Returns 204 if successfully add subscribers to a topic by key.
      def add_subscribers(topic_key, body)
        post("/topics/#{topic_key}/subscribers", body: body)
      end

      # Remove subscribers from a topic
      #
      # @pathparams
      # @param `topic_key` [String]

      # @bodyparams:
      # @param `subscribers` [Array] List of subscriber identifiers that will be removed to the topic
      #
      # @return [number] status - The status code. Returns 204 if successfully remove subscribers to a topic by key.
      def remove_subscribers(topic_key, body)
        post("/topics/#{topic_key}/subscribers/removal", body: body)
      end

      # Get a topic by its topic key
      #
      # @pathparams
      # @param `topic_key` [String]
      #
      # @return [Hash] The retrieved topic.
      # @return [number] status
      #  - Returns 200 if successful
      def topic(topic_key)
        get("/topics/#{topic_key}")
      end

      # Rename a topic by providing a new name
      #
      # @pathparams
      # @param `topic_key` [String]
      #
      # @bodyparams:
      # @param `name` [String] User defined custom name and provided by the user to rename the topic.
      #
      # @return [Hash] Updated topic enitiy.
      # @return [number] status
      #  - Returns 200 if successful
      def rename_topic(topic_key, body)
        patch("/topics/#{topic_key}", body: body)
      end
    end
  end
end
