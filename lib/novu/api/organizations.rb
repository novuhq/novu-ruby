# frozen_string_literal: true

module Novu
	class Api
		# Module Novu::Api::Organizations provides an API for managing Organization within your Novu account.
		#
		# This module includes methods for creating, retrieving, updating and deleting organization.
		#
		# For more information on the Novu API see https://api.novu.co/api#/Organizations, https://docs.novu.co/api-reference/organizations/create-organization.
		module Organizations
			# Create an organization
      #
      # @bodyparams:
      # @param `logo` [String] - A valid image URL with one of the following extensions: jpg, jpeg, png, gif, svg.
      # @param `name` [String] - A human-readable name of the organization.
      #
      # @return [Hash] data - The list of information with respect to the created organization.
      # @return [number] status - The status code. Returns 200 if the organization has been successfully created.
      def create_organization(body)
        post("/organizations", body: body)
      end

      # Returns a list of organizations
      #
      # @return [Hash] data - The list of organizations already created.
      # @return [number] status - Returns 200 if successful
      def organizations()
        get("/organizations")
      end

      # Get details of the current organization
      #
      # @return [Hash] data - The details of the current organization.
      # @return [number] status - Returns 200 if successful
      def current_organization()
        get("/organizations/me")
      end

      # Get all members of the current organization
      #
      # @return [Hash] data - The list of all members of the current organization.
      # @return [number] status - Returns 200 if successful
      def current_organization_members()
        get("/organizations/members")
      end

      # Rename organization name
      #
      # @return [Hash] data - The list of updated details of the organization.
      # @return [number] status - Returns 200 if successful
      def rename_organization(body)
        patch("/organizations", body: body)
      end

      # Update organization branding details
      #
      # @bodyparams:
      # @param `logo` [String] - A valid image URL with one of the following extensions: jpg, jpeg, png, gif, svg.
      # @param `color` [String] - The hexadecimal color style of the organization.
      # @param `contentBackground` [String] - The hexadecimal content background style of the organization.
      # @param `fontColor` [String] - The hexadecimal font color style of the organization.
      # @param `fontFamily` [String(optional)] - The font family style of the organization.
      #
      # @return [Hash] data - The list of branding details of the organization.
      # @return [number] status - Returns 200 if successful
      def organization_branding(body)
        put("/organizations/branding", body: body)
      end

      # Remove a member from organization
      #
      # @pathparams
      # @param `member_id` [String]
      #
      # @return [number] status - The status code. Returns 200 if memeber was removed successfully by their id.
      def delete_organization_member(member_id)
        delete("/organizations/members/#{member_id}")
      end
		end
	end
end