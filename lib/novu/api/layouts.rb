# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Layouts provides an API for managing layouts in the Novu application.
    #
    # This module includes methods for creating, retrieving, updating, and deleting layouts.
    # It also includes methods for setting and getting the default layout.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Layouts), see https://novu.com/api/docs.
    module Layouts
      # Creates a new layout.
      #
      # @bodyparams:
      # @param `name` [String] User defined custom name and provided by the user that will name the Layout created.
      # @param `content` [String] User defined content for the layout.
      # @param `description` [String(optional)] User description of the layout.
      # @param `variables` [Array(optional)] User defined variables to render in the layout placeholders.
      # @param `isDefault` [Boolean(optional)] User defined variables to render in the layout placeholders.
      #
      # @return [_id: "_id"] The created layout id.
      # @return [number] status - The status code. Returns 201 if the layout has been successfully created.
      def create_layout(body)
        post("/layouts", body: body)
      end

      # Returns a list of layouts that can be paginated using the `page` query parameter and
      # filtered by the environment where it is executed from the organization the user belongs to.
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination.
      # @param `pageSize` [Integer(optional)] Size of page for the pagination.
      # @param `sortBy` [String(optional)] Sort field. Currently only supported `createdAt`.
      # @param `orderBy` [Integer(optional)] Direction of the sorting query param. Either ascending (1) or descending (-1).
      #
      # @return [Hash] The list of layouts that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful,
      #  - Returns 400 if Page size can not be larger than the page size limit.
      def layouts(query = {})
        get("/layouts", query: query)
      end

      # Retrieves the layout with the given ID.
      #
      # @pathparams
      # @param `layout_id` [Integer] The ID of the layout to retrieve.
      # 
      # @return [Hash] The retrieved layout.
      # @return [number] status
      #  - Returns 200 if the layout with the layoutId provided exists in the database.
      #  - Returns 404 The layout with the layoutId provided does not exist in the database.
      def layout(layout_id)
        get("/layouts/#{layout_id}")
      end

      # Execute a soft delete of a layout given a certain ID.
      #
      # @pathparams:
      # @param `layout_id` [Integer] The ID of the layout to delete.
      # 
      # @return [Hash] The retrieved layout.
      # @return [number] status
      #  - Returns 204 if the layout has been deleted correctly.
      #  - Returns 404 if the layout with the layoutId provided does not exist in the database so it can not be deleted.
      #  - Returns 409 if either you are trying to delete a layout that is being used or a layout that is the default in the environment.
      def delete_layout(layout_id)
        delete("/layouts/#{layout_id}")
      end

      # Update the name, content and variables of a layout. Also change it to be default or no.
      #
      # @pathparams:
      # @param `layout_id` [Integer] The ID of the layout to update.
      # 
      # @bodyparams
      # @param `name` [String(optional)] User defined custom name and provided by the user that will name the Layout updated.
      # @param `description` [String(optional)] User defined description of the layout.
      # @param `content` [String(optional)] User defined content for the layout.
      # @param `variables` [Array(optional)] User defined variables to render in the layout placeholders.
      # @param `isDefault` [Boolean(optional)] Variable that defines if the layout is chosen as default when creating a layout.
      # 
      # @return [Hash] The updated layout.
      # @return [number] status
      #  - Returns 200 if the layout with the layoutId provided has been updated correctly.
      #  - Returns 400 if the payload provided or the URL param are not right.
      #  - Returns 404 if the layout with the layoutId provided does not exist in the database so it can not be updated.
      #  - Returns 409 if one default layout is needed. If you are trying to turn a default layout as not default, you should turn a different layout as default first and automatically it will be done by the system.
      def update_layout(layout_id, body)
        patch("/layouts/#{layout_id}", body: body)
      end

      # Sets the default layout for the environment and updates to non default to the existing default layout (if any).
      #
      # @pathparams:
      # @param `layout_id` [Integer] The ID of the layout to set the default.
      #
      # @return [number] status
      #  - Returns 204 if the selected layout has been set as the default for the environment.
      #  - Returns 404 if the layout with the layoutId provided does not exist in the database so it can not be set as the default for the environment.
      def make_default_layout(layout_id)
        post("/layouts/#{layout_id}/default")
      end
    end
  end
end
