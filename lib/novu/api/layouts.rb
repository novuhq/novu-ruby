# frozen_string_literal: true

# Module Novu::Api::Layouts provides an API for managing layouts in the Novu application.
#
# This module includes methods for creating, retrieving, updating, and deleting layouts.
# It also includes methods for setting and getting the default layout for a given user.
#
# Example usage:
#
#   Novu::Api::Layouts.create_layout(name: "My Layout", template: "template1")
#   Novu::Api::Layouts.layout(layout_id: 123)
#   Novu::Api::Layouts.layouts()
#   Novu::Api::Layouts.update_layout(layout_id: 123, name: "New Name")
#   Novu::Api::Layouts.delete_layout(layout_id: 123)
#   Novu::Api::Layouts.make_default_layout(layout_id: 123)
#
# For more information on the Novu API, see https://novu.com/api/docs.

module Novu
  class Api
    module Layouts
      def create_layout(body)
        post("/layouts", body)
      end

      def layouts(options = {})
        get("/layouts", options)
      end

      def layout(layout_id)
        get("/layouts/#{layout_id}")
      end

      def delete_layout(layout_id)
        delete("/layouts/#{layout_id}")
      end

      def update_layout(layout_id, body)
        patch("/layouts/#{layout_id}", body)
      end

      def make_default_layout(layout_id)
        post("/layouts/#{layout_id}/default")
      end
    end
  end
end
