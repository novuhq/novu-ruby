# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::WorkflowOverrides do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:override_id) { "985277" }
	let(:workflow_id) { "3f71b3ef067" }
	let(:tenant_id) { "ecaf52336" }

  describe "#create_workflow_overrides" do
    it "creates a workflow override" do
      body = {
        tenantId: "string",
        workflowId: "string",
        active: true
      }

      response_body = {
        "data": {
            "_environmentId": "<string>",
            "_id": "<string>",
            "_organizationId": "<string>",
            "_tenantId": "<string>",
            "_workflowId": "<string>",
            "active": true,
            "createdAt": "<string>",
            "deleted": true,
            "deletedAt": "<string>",
            "deletedBy": "<string>",
            "preferenceSettings": {
            "chat": true,
            "email": true,
            "in_app": true,
            "push": true,
            "sms": true
            },
            "updatedAt": "<string>"
        }
      }.to_json

      stub_request(:post, "#{base_uri}/workflow-overrides")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.create_workflow_overrides(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#get_workflow_overrides" do
		it "returns all workflow overrides" do
			response_body = {
				page: 0,
				hasMore: false,
				pageSize: 10,
				data: [
					{
						_id: "63f71b3ef067290fa669106d"
					}
				]
			}.to_json

			stub_request(:get, "#{base_uri}/workflow-overrides")
				.to_return(status: 200, body: response_body)

			result = client.get_workflow_overrides

			expect(result.body).to eq(response_body)
			expect(result.code).to eq(200)
		end
  end

  describe "#get_tenant_workflow_override" do
    it "get tenant workflow overrides" do
      stub_request(:get, "#{base_uri}/workflow-overrides/workflows/#{workflow_id}/tenants/#{tenant_id}")
        .to_return(status: 200)

      result = client.get_tenant_workflow_override(workflow_id, tenant_id)
      expect(result.code).to eq(200)
    end
  end

  describe "#get_workflow_override_by_id" do
    it "get workflow override by it's ID" do
      stub_request(:get, "#{base_uri}/workflow-overrides/#{override_id}")
        .to_return(status: 200)

      result = client.get_workflow_override_by_id(override_id)

      expect(result.code).to eq(200)
    end
  end

  describe "#update_workflow_override_by_id" do
    it "update workflow override details" do
      body = {
        active: true
      }

      stub_request(:put, "#{base_uri}/workflow-overrides/#{override_id}")
        .with(body: body)
        .to_return(status: 200)

      result = client.update_workflow_override_by_id(override_id, body)
      expect(result.code).to eq(200)
    end
  end

	describe "#update_tenant_workflow_override" do
    it "update workflow override details" do
      body = {
        active: true
      }

      stub_request(:put, "#{base_uri}/workflow-overrides/workflows/#{workflow_id}/tenants/#{tenant_id}")
        .with(body: body)
        .to_return(status: 200)

      result = client.update_tenant_workflow_override(workflow_id, tenant_id, body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_workflow_override" do
    it "delete a workflow override" do
      response_body = {
        data: true
      }.to_json

      stub_request(:delete, "#{base_uri}/workflow-overrides/#{override_id}")
        .to_return(status: 200, body: response_body)

      result = client.delete_workflow_override(override_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
