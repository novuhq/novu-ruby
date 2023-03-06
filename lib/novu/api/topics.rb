# frozen_string_literal: true

module Novu
  class Api
    module Topics
      def create_topic(body)
        post("/topics", body)
      end

      def topics(options = {})
        get("/topics", options)
      end

      def add_subscribers(topic_key, body)
        post("/topics/#{topic_key}/subscribers", body)
      end

      def remove_subscribers(topic_key, body)
        post("/topics/#{topic_key}/subscribers/removal", body)
      end

      def topic(topic_key)
        get("/topics/#{topic_key}")
      end

      def rename_topic(topic_key, body)
        patch("/topics/#{topic_key}", body)
      end
    end
  end
end
