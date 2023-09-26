# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Tenants provides an API for managing tenants in the Novu application.
    #
    # This module includes methods for creating, retrieving, updating and deleting tenant.
    #
    # For more information on the tenants feature (https://docs.novu.co/tenants/introduction), 
    # for API documentation see https://docs.novu.co/api-reference/tenants/get-tenants.
    module Tenants
      # Create a tenant
      #
      # @bodyparams:
      # @param `identifier` [String] - A unique value, and can be used later when pointing to this tenant during trigger calls.
      # @param `name` [String] - A human-readable name of the tenant.
      # @param `data` [Hash] - A custom data object that can store information about the tenant. 
      #
      # @return [Hash] data - The list of information with respect to the created tenant are successfully returned.
      # @return [number] status - The status code. Returns 200 if the tenant has been successfully created.
      def create_tenant(body)
        post("/tenants", body: body)
      end

      # Returns a list of tenant that can be paginated using the `page` query parameter and
      #  set the number of tenants to be with the `limit` query parameter
      #
      # @queryparams:
      # @param `page` [Integer(optional)] - Number of page for the pagination.
      # @param `limit` [Integer(optional)] - Size of page for the pagination.
      #
      # @return [Hash] data - The list of tenants that match the criteria of the query params are successfully returned.
      # @return [Boolean] hasMore - To specify if the list have more items to fetch
      # @return [number] page - The current page of the paginated response
      # @return [number] pageSize - The number of size of each page
      # @return [number] status
      #  - Returns 200 if successful
      def tenants(query = {})
        get("/tenants", query: query)
      end

      # Get a tenant by the tenant identifier
      #
      # @pathparams
      # @param `identifier` [String]
      #
      # @return [Hash] data -The retrieved topic.
      # @return [number] status
      #  - Returns 200 if successful
      def tenant(identifier)
        get("/tenants/#{identifier}")
      end

      # Update a tenant
      #
      # @pathparams
      # @param `identifier` [String]
      #
      # @bodyparams:
      # @param `identifier` [String] - A unique value, and can be used later when pointing to this tenant during trigger calls.
      # @param `name` [String] - A human-readable name of the tenant.
      # @param `data` [Hash] - A custom data object that can store information about the tenant. This data can be later accessed inside workflows.
      #
      # @return [Hash] data - The list of information with respect to the created tenant are successfully returned.
      # @return [number] status - The status code. Returns 200 if the tenant has been successfully created.
      def update_tenant(identifier, body)
        patch("/tenants/#{identifier}", body: body)
      end

      # Using a previously create identifier during the tenant ceation, will cancel any active or pending workflows.
      # This is useful to cancel active digests, delays etc...
      #
      # @pathparams:
      # @param `identifier` [String] - identifier of the tenant
      #
      # @return [number] status - The status code. Returns 200 if the event has been successfully cancelled.
      def delete_tenant(identifier)
        delete("/tenants/#{identifier}")
      end
    end
  end
end