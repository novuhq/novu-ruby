# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::NotificationTemplates provides an API for managing notification templates in the Novu application.
    #
    # This module includes methods for creating, retrieving, updating, and deleting layouts.
    # It also includes methods for creating and retrieving the notification blueprint.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Layouts), see https://docs.novu.co/api/layout-creation/.
    module NotificationTemplates
      # Returns a list of notification template that can be paginated using the `page` query parameter
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination.
      # @param `limit` [Integer(optional)]
      #
      # @return [Hash] The list of notification templates that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def notification_templates(query = {})
        get("/notification-templates", query: query)
      end

      # Creates a new notification template.
      #
      # @bodyparams:
      # @param `name` [String]
      # @param `notificationGroupId` [String]
      # @param `tags` [Array(optional)]
      # @param `description` [String(optional)]
      # @param `steps` [Array]
      # @param `active` [Boolean(optional)]
      # @param `draft` [Boolean(optional)]
      # @param `critical` [Boolean(optional)]
      # @param `preferenceSettings` [Hash(optional)]
      #
      # @return [Hash] Notification template entity.
      # @return [number] status - The status code. Returns 201 if the notification template has been successfully created.
      def create_notification_template(body)
        post("/notification-templates", body: body)
      end

      # Updates new notification template.
      #
      # @pathparams:
      # @param `template_id` [String] The ID of the notification template to update.
      #
      # @bodyparams:
      # @param `name` [String]
      # @param `tags` [Array(optional)]
      # @param `description` [String(optional)]
      # @param `identifier` [String(optional)]
      # @param `steps` [Array(optional)]
      # @param `notificationGroupId` [String]
      # @param `active` [Boolean(optional)]
      # @param `critical` [Boolean(optional)]
      # @param `preferenceSettings` [Hash(optional)]
      #
      # @return [Hash] Updated notification template entity.
      # @return [number] status - The status code. Returns 200 if the notification template has been successfully updated.
      def update_notification_template(template_id, body)
        put("/notification-templates/#{template_id}", body: body)
      end

      # Execute a soft delete of a notification template given a certain ID.
      #
      # @pathparams:
      # @param `template_id` [String] The ID of the template to delete.
      #
      # @return [number] status
      #  - Returns 200 if the layout has been deleted correctly.
      def delete_notification_template(template_id)
        delete("/notification-templates/#{template_id}")
      end

      # Retrieves the notification template with the given ID.
      #
      # @pathparams
      # @param `template_id` [String] The ID of the template to retrieve.
      #
      # @return [Hash] The retrieved template.
      # @return [number] status
      #  - Returns 200 if the template with the template_id provided exists in the database.
      def notification_template(template_id)
        get("/notification-templates/#{template_id}")
      end

      # Retrieves the notification template blueprint with the given ID.
      #
      # @pathparams
      # @param `template_id` [String] The ID of the template to retrieve.
      #
      # @return [Hash] The retrieved template blueprint.
      # @return [number] status
      #  - Returns 200 if the template blueprint with the template_id provided exists in the database.
      def notification_template_blueprint(template_id)
        get("/notification-templates/#{template_id}/blueprint")
      end

      # Creates a new notification template blueprint.
      #
      # @return [Hash] Notification template blueprint entity.
      # @return [number] status - The status code. Returns 201 if the notification template blueprint has been successfully created.
      def create_notification_template_blueprint(template_id)
        post("/notification-templates/#{template_id}/blueprint")
      end

      # Update notification template status
      #
      # @pathparams:
      # @param `template_id` [String] The ID of the template to update.
      #
      # @bodyparams
      # @param `active` [Boolean]
      #
      # @return [Hash] The updated layout.
      # @return [number] status
      #  - Returns 200 if the layout with the template_id provided has been updated correctly.
      def update_notification_template_status(template_id, body)
        put("/notification-templates/#{template_id}/status", body: body)
      end
    end
  end
end
