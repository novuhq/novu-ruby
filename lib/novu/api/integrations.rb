# frozen_string_literal: true

module Novu
  class Api
    module Integrations
      def integrations(query = {})
        get("/integrations", query: query)
      end

      def create_integration(body)
        post("/integrations", body: body)
      end

      def active_integrations
        get("/integrations/active")
      end

      def webhook_provider_status(provider_id)
        get("/integrations/webhook/provider/#{provider_id}/status")
      end

      def update_integration(integration_id, body)
        put("/integrations/#{integration_id}", body: body)
      end

      def delete_integration(integration_id)
        delete("/integrations/#{integration_id}")
      end

      def channel_limit(channel_type)
        get("/integrations/#{channel_type}/limit")
      end

      def in_app_status
        get("/integrations/in-app/status")
      end
    end
  end
end
