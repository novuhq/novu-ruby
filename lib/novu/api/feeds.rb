# frozen_string_literal: true

module Novu
  class Api
    module Feeds
      def create_feed(body)
        post("/feeds", body: body)
      end

      def feeds
        get("/feeds")
      end

      def delete_feed(feed_id)
        delete("/feeds/#{feed_id}")
      end
    end
  end
end
