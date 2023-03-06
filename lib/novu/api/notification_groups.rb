# frozen_string_literal: true

module Novu
  class Api
    module NotificationGroups
      def create_notification_group(body)
        post("/notification-groups", body: body)
      end

      def notification_groups
        get("/notification-groups")
      end
    end
  end
end
