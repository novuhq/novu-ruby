# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Integrations do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#integrations" do
    it "returns a list of integrations" do
      response_body = {
        _id: "string",
        _environmentId: "string"
      }.to_json

      stub_request(:get, "#{base_uri}/integrations")
        .to_return(status: 200, body: response_body)

      result = client.integrations

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#create_integration" do
    it "creates a new integration" do
      body = {
        providerId: "string",
        channel: "in_app"
      }.to_json

      response_body = {
        _id: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/integrations")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_integration(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#active_integrations" do
    it "returns a list of active integrations" do
      response_body = {
        _organizationId: "string",
        active: true
      }.to_json

      stub_request(:get, "#{base_uri}/integrations/active")
        .to_return(status: 200, body: response_body)

      result = client.active_integrations

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#webhook_provider_status" do
    it "returns webhook support status for provider" do
      provider_id = "1234"

      stub_request(:get, "#{base_uri}/integrations/webhook/provider/#{provider_id}/status")
        .to_return(status: 200)

      result = client.webhook_provider_status(provider_id)

      expect(result.code).to eq(200)
    end
  end

  describe "#update_integration" do
    it "update the credentials of a integration." do
      integration_id = "string"

      body = {
        active: true,
        credentials: { token: "new-slack-token" }
      }.to_json

      response_body = {
        _id: integration_id
      }.to_json

      stub_request(:put, "#{base_uri}/integrations/#{integration_id}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_integration(integration_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_integration" do
    it "execute a soft delete of a integration given a certain id." do
      integration_id = "63f71b3ef067290fa669106d"

      response_body = {
        _id: "string",
        deleted: true,
        deletedAt: "string",
        deletedBy: "string"
      }.to_json

      stub_request(:delete, "#{base_uri}/integrations/#{integration_id}")
        .to_return(status: 200, body: response_body)

      result = client.delete_integration(integration_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#channel_limit" do
    it "returns a channel limit" do
      channel_type = "email"

      stub_request(:get, "#{base_uri}/integrations/#{channel_type}/limit")
        .to_return(status: 200)

      result = client.channel_limit(channel_type)

      expect(result.code).to eq(200)
    end
  end

  describe "#in_app_status" do
    it "returns in-app status" do
      stub_request(:get, "#{base_uri}/integrations/in-app/status")
        .to_return(status: 200)

      result = client.in_app_status

      expect(result.code).to eq(200)
    end
  end

  describe "#set_integration_as_primary" do
    it "sets an integration as primary" do
      integration_id = "string"
      response_body = {
        _id: "string"
      }.to_json
      
      stub_request(:post, "#{base_uri}/integrations/#{integration_id}/set-primary")
        .to_return(status: 200, body: response_body)

      result = client.set_integration_as_primary(integration_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
