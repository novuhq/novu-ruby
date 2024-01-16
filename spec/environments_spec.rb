# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Environments do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#environment" do
    it "returns the current environment" do
      response_body = {
        _id: "environment_id",
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/environments/me")
        .to_return(status: 200, body: response_body)

      result = client.current_environment

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#create_environment" do
    it "creates a new environment" do
      body = {
        name: "string",
        parentId: "string"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:post, "#{base_uri}/environments")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_environment(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#environments" do
    it "returns all environments" do
      response_body = {
        "page": 0,
        "totalCount": 2,
        "pageSize": 10,
        "data": [
          {
            "_id": "63f71b3ef067290fa669106d"
          }
        ]
      }.to_json

      stub_request(:get, "#{base_uri}/environments")
        .to_return(status: 200, body: response_body)

      result = client.environments

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_environment" do
    it "updates the specified environment" do
      environment_id = "63f71b3ef067290fa669106d"

      body = {
        name: "environment_id",
        identifier: "John"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:put, "#{base_uri}/environments/#{environment_id}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_environment(environment_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#api_keys" do
    it "get the api keys" do
      response_body = {
        key: "string",
        _userId: "string"
      }.to_json

      stub_request(:get, "#{base_uri}/environments/api-keys")
        .to_return(status: 200, body: response_body)

      result = client.api_keys

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#regenerate_api_keys" do
    it "return regenerated api keys" do
      response_body = {
        key: "string",
        _userId: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/environments/api-keys/regenerate")
        .to_return(status: 200, body: response_body)

      result = client.regenerate_api_keys

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_widget_settings" do
    it "update the widget settings." do
      body = {
        notificationCenterEncryption: true
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:put, "#{base_uri}/environments/widget/settings")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_widget_settings(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
