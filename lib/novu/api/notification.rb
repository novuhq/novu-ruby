# frozen_string_literal: true

module Novu
  class Api
    module Notification
      def notifications(query = {})
        get("/notifications", query: query)
      end
      
      def notifications_stats(query = {})
        get("/notifications/stats", query: query)
      end

      def notifications_graph_stats(query = {})
        get("/notifications/graph/stats", query: query)
      end

      def notification(notification_id)
        get("/notifications/#{notification_id}", )
      end

    end
  end
end
