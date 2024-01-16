# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Layouts do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:layout_id) { "63f71b3ef067290fa669106d" }

  describe "#create_layout" do
    it "creates a new layout" do
      body = {
        name: "string",
        description: "string"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:post, "#{base_uri}/layouts")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_layout(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#layouts" do
    context "when no query params are passed" do
      it "returns all layouts" do
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

        stub_request(:get, "#{base_uri}/layouts")
          .to_return(status: 200, body: response_body)

        result = client.layouts

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end

    context "when the 'page' query param is passed" do
      it "returns the layouts for the specified page" do
        query_params = { page: 2 }
        response_body = {
          "page": 2,
          "totalCount": 12,
          "pageSize": 10,
          "data": [
            {
              "_id": "63f71b3ef067290fa669106d"
            }
          ]
        }.to_json

        stub_request(:get, "#{base_uri}/layouts?page=2")
          .to_return(status: 200, body: response_body)

        result = client.layouts(query_params)

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end
  end

  describe "#layout" do
    it "returns the specified layout" do
      response_body = {
        _id: layout_id,
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/layouts/#{layout_id}")
        .to_return(status: 200, body: response_body)

      result = client.layout(layout_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_layout" do
    it "deletes the specified layout" do
      stub_request(:delete, "#{base_uri}/layouts/#{layout_id}")
        .to_return(status: 204)

      result = client.delete_layout(layout_id)

      expect(result.code).to eq(204)
    end
  end

  describe "#update_layout" do
    it "update the name, content and variables of a layout" do
      body = {
        name: "string"
      }.to_json

      response_body = {
        name: "string",
        _id: "12134"
      }.to_json

      stub_request(:patch, "#{base_uri}/layouts/#{layout_id}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_layout(layout_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#make_default_layout" do
    it "sets the default layout for the environment and updates to non default to the existing default layout" do
      stub_request(:post, "#{base_uri}/layouts/#{layout_id}/default")
        .to_return(status: 204)

      result = client.make_default_layout(layout_id)

      expect(result.code).to eq(204)
    end
  end
end
