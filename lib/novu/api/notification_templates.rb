# frozen_string_literal: true

module Novu
  class Api
    module NotificationTemplates
      def notification_templates(options = {})
        get("/notification-templates", query: options)
      end

      def create_notification_template(body)
        post("/notification-templates", body: body)
      end

      def update_notification_template(template_id, body)
        put("/notification-templates/#{template_id}", body: body)
      end

      def delete_notification_template(template_id)
        delete("/notification-templates/#{template_id}")
      end

      def notification_template(template_id)
        get("/notification-templates/#{template_id}")
      end

      def notification_template_blueprint(template_id)
        get("/notification-templates/#{template_id}/blueprint")
      end

      def create_notification_template_blueprint(template_id)
        post("/notification-templates/#{template_id}/blueprint")
      end

      def update_notification_template_status(template_id, body)
        put("/notification-templates/#{template_id}/status", body: body)
      end
    end
  end
end
