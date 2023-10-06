# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Blueprints provides an API for managing templated for notifications that are sent out in the Novu application.
    #
    # This module includes methods for retrieving blueprints by templateID and grouping blueprints by category.
    #
    # For more information on the Novu Blueprint API, see https://docs.novu.co/api/get-messages/.
    module Blueprints
      # Returns the details of a particular template
      #
      # @pathParams 
      # @param `template_id` [String]
      #
      # @return [Hash] The list of properties that pertains to the template e.g. _id, name, description, active, draft, preferenceSettings, and many others.
      # @return [number] status
      #  - Returns 200 if successful
      def get_blueprint(template_id)
        get("/blueprints/#{template_id}")
      end

      # Get V1blueprintsgroup by Category
      def group_blueprints_by_category
        get("/blueprints/group-by-category")
      end
    end
  end
end
