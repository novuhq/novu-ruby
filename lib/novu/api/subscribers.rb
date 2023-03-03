# frozen_string_literal: true

module Novu
  class Api
    module Subscribers
      def subscribers(options = {})
        get("/subscribers", options)
      end

      def create_subscriber(body)
        post("/subscribers", body)
      end

      def subscriber(subscriber_id)
        get("/subscribers/#{subscriber_id}")
      end

      def update_subscriber(subscriber_id, body)
        put("/subscribers/#{subscriber_id}", body)
      end

      def delete_subscriber(subscriber_id)
        delete("/subscribers/#{subscriber_id}")
      end

      # TODO: test below endpoints

      def update_subscriber_credentials(subscriber_id, body)
        put("/subscribers/#{subscriber_id}/credentials", body)
      end

      def update_subscriber_online_status(subscriber_id, body)
        put("/subscribers/#{subscriber_id}/online-status", body)
      end

      def subscriber_preferences(subscriber_id)
        get("/subscribers/#{subscriber_id}/preferences")
      end

      def update_subscriber_preference(subscriber_id, template_id, body)
        patch("/subscribers/#{subscriber_id}/preferences/#{template_id}", body)
      end

      def subscriber_notification_feed(subscriber_id, body)
        get("/subscribers/#{subscriber_id}/notifications/feed", body)
      end

      def subscriber_unseen_notification_count(subscriber_id, body)
        get("/subscribers/#{subscriber_id}/notifications/unseen", body)
      end

      def mark_subscriber_feed_seen(subscriber_id, body)
        post("/subscribers/#{subscriber_id}/messages/markAs", body)
      end

      def mark_message_action_seen(subscriber_id, message_id, type)
        post("/subscribers/#{subscriber_id}/messages/#{message_id}/actions/#{type}")
      end
    end
  end
end
