# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::ExecutionDetails provides an API for managing execution details in the Novu application.
    #
    # This module includes method for retrieving execution details.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Execution%20Details), see https://docs.novu.co/api/get-execution-details/.
    module ExecutionDetails
      # Returns a list of execution details
      #
      # @queryparams:
      # @param `notificationId` [String]
      # @param `subscriberId` [String]
      #
      # @return [Hash] The list of execution details that match the criteria of the query params are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
      def execution_details(query = {})
        get("/execution-details", query: query)
      end
    end
  end
end
