# frozen_string_literal: true

module Novu
  class Api
    module Messages
      def messages(query = {})
        get("/messages", query: query)
      end

      def delete_message(message_id)
        delete("/messages/#{message_id}")
      end
    end
  end
end
