# frozen_string_literal: true

module Novu
  class Api
    module Notification
      def notifications(options = {})
        get("/notifications", options)
      end
      
      def notifications_stats(options = {})
        get("/notifications/stats", options)
      end

      def notifications_graph_stats(options = {})
        get("/notifications/graph/stats", options)
      end

      def notification(notification_id)
        get("/notifications/#{notification_id}", )
      end

    end
  end
end
