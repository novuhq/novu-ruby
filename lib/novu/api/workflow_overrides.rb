# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::WorkflowOverrides provides an API for managing workflow overrides within your Novu account.
    #
    # This module includes methods for creating, retrieving, updating and deleting workflow overrides.
    #
    # For more information on the Novu API see https://api.novu.co/api#/Workflows-Overrides, https://docs.novu.co/api-reference/workflow-overrides
    module WorkflowOverrides

			# Create workflow overrides
			#
			# @bodyparams:
			# @param `active` [Boolean] - The status of the workflow.
			# @param `tenantId` [String] - The ID of the tenant.
			# @param `workflowId` [String] - The ID of the workflow.
			# @param `preferenceSettings` [Hash (Optional)] - A custom preference settings object that can store information about the workflow
			#
			# @return [Hash] data - The list of information with respect to the created workflow.
			# @return [number] status - The status code. 
			def create_workflow_overrides(body)
				post("/workflow-overrides", body: body.to_json, headers: {'Content-Type': 'application/json'})
			end
			
			# Returns a list of workflow overrides that can be paginated using the `page` 
			# and `limit` query parameter
      #
      # @queryparams:
      # @param `page` [Integer(optional)] Number of page for the pagination.
      # @param `limit` [Integer(optional)]
      #
      # @return [Hash] The list of workflow overrides are successfully returned.
      # @return [number] status
      #  - Returns 200 if successful
			def get_workflow_overrides(query = {})
				get("/workflow-overrides", query: query)
			end

			# Returns a workflow ovverride
      #
      # @pathparams:
      # @param `workflow_id` [String]
      # @param `tenant_id` [String]
      #
      # @return [Hash] workflow override entity
      # @return [number] status
      #  - Returns 200 if successful.
			def get_tenant_workflow_override(workflow_id, tenant_id)
				get("/workflow-overrides/workflows/#{workflow_id}/tenants/#{tenant_id}")
			end

			# Get the details of a workflow ovverride by it's ID
      #
      # @pathparams:
      # @param `override_id` [String]
      #
      # @return [Hash] workflow override entity
      # @return [number] status
      #  - Returns 200 if successful.
			def get_workflow_override_by_id(override_id)
				get("/workflow-overrides/#{override_id}")
			end

			# Update workflow ovverride by it's ID
      #
      # @pathparams:
      # @param `override_id` [String]
			#
			# @bodyParam:
			# @param `active` [Boolean] - The status of the workflow.
      # @param `preferenceSettings` [Hash] - The preference settings of the workflow. It should include any/all of following keys: chat, email, sms, in_app, push.
      #
      # @return [Hash] workflow override entity
      # @return [number] status
      #  - Returns 200 if successful.
			def update_workflow_override_by_id(override_id, body)
				put("/workflow-overrides/#{override_id}", body: body.to_json, headers: {'Content-Type': 'application/json'})
			end

			# Update tenant workflow ovverride
      #
      # @pathparams:
      # @param `workflow_id` [String]
      # @param `tenant_id` [String]
			#
			# @bodyParam:
			# @param `active` [Boolean] - The status of the workflow.
      # @param `preferenceSettings` [Hash] - The preference settings of the workflow. It should include any/all of following keys: chat, email, sms, in_app, push.
      #
      # @return [Hash] workflow override entity
      # @return [number] status
      #  - Returns 200 if successful.
			def update_tenant_workflow_override(workflow_id, tenant_id, body)
				put("/workflow-overrides/workflows/#{workflow_id}/tenants/#{tenant_id}", body: body.to_json, headers: {'Content-Type': 'application/json'})
			end
 			
			# Delete a workflow override by it's ID.
      #
      # @pathparams:
      # @param `override_id` [Integer] The ID of the workflow override.
      #
      # @return [Hash] The result of the deletion.
      # @return [number] status
      #  - Returns 200 if the workflow has been deleted correctly.
			def delete_workflow_override(override_id)
				delete("/workflow-overrides/#{override_id}")
			end
		end
	end
end