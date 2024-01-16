# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Tenants do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:identifier) { "a_unique_string" }

  describe "#create_tenant" do
    it "creates a new tenant" do
      body = {
        identifier: identifier,
        name: "a new tenant"
      }.to_json

      response_body = {}.to_json

      stub_request(:post, "#{base_uri}/tenants")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.create_tenant(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#tenants" do
    context "when no query params are passed" do
      it "returns all tenants" do
        response_body = {
          page: 0,
          hasMore: true,
          pageSize: 10,
          data: []
        }.to_json

        stub_request(:get, "#{base_uri}/tenants")
          .to_return(status: 200, body: response_body)

        result = client.tenants

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end

    context "when the 'page' query param is passed" do
      it "returns the tenants for the specified page number" do
        query_params = { page: 1 }
        response_body = {
          page: 0,
          hasMore: true,
          pageSize: 10,
          data: []
        }.to_json

        stub_request(:get, "#{base_uri}/tenants?page=1")
          .to_return(status: 200, body: response_body)

        result = client.tenants(query_params)

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end
  end

  describe "#tenant" do
    it "returns a tenant by the tenant identifier key" do
      response_body = {
        data: []
      }.to_json

      stub_request(:get, "#{base_uri}/tenants/#{identifier}")
        .to_return(status: 200, body: response_body)

      result = client.tenant(identifier)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_tenant" do
    it "update a tenant by your internal id used to identify the tenant" do
      body = {
        name: "string"
      }.to_json

      response_body = {
        data: []
      }.to_json

      stub_request(:patch, "#{base_uri}/tenants/#{identifier}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_tenant(identifier, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_tenant" do
    it "delete a tenant entity" do
      stub_request(:delete, "#{base_uri}/tenants/#{identifier}")
        .to_return(status: 204)

      result = client.delete_tenant(identifier)
      expect(result.code).to eq(204)
    end
  end
end
