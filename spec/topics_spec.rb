# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Topics do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:topic_key) { "test-topic" }

  describe "#create_topic" do
    it "creates a new topic" do
      body = {
        key: "string",
        name: "string"
      }.to_json

      response_body = {}.to_json

      stub_request(:post, "#{base_uri}/topics")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_topic(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#topics" do
    context "when no query params are passed" do
      it "returns all topics" do
        response_body = {
          page: 0,
          totalCount: 2,
          pageSize: 10,
          data: [
            {
              _id: "63f71b3ef067290fa669106d"
            }
          ]
        }.to_json

        stub_request(:get, "#{base_uri}/topics")
          .to_return(status: 200, body: response_body)

        result = client.topics

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end

    context "when the 'key' query param is passed" do
      it "returns the topic for the specified key" do
        query_params = { key: "test-topic" }
        response_body = {
          page: 0,
          totalCount: 1,
          pageSize: 10,
          data: [
            {
              key: "test-topic"
            }
          ]
        }.to_json

        stub_request(:get, "#{base_uri}/topics?key=test-topic")
          .to_return(status: 200, body: response_body)

        result = client.topics(query_params)

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end
  end

  describe "#add_subscribers" do
    it "add subscribers to a topic by key" do
      body = {
        subscribers: [
          "string"
        ]
      }.to_json

      stub_request(:post, "#{base_uri}/topics/#{topic_key}/subscribers")
        .with(body: body)
        .to_return(status: 204)

      result = client.add_subscribers(topic_key, body)

      expect(result.code).to eq(204)
    end
  end

  describe "#remove_subscribers" do
    it "remove subscribers to a topic by key" do
      body = {
        subscribers: [
          "string"
        ]
      }.to_json

      stub_request(:post, "#{base_uri}/topics/#{topic_key}/subscribers/removal")
        .with(body: body)
        .to_return(status: 204)

      result = client.remove_subscribers(topic_key, body)

      expect(result.code).to eq(204)
    end
  end

  describe "#subscriber_topic" do
    it "Check if a subscriber belongs to a certain topic" do
      body = ""

      stub_request(:get, "#{base_uri}/topics/#{topic_key}/subscribers/string")
        .to_return(status: 200)

      result = client.subscriber_topic(topic_key, 'string')
      expect(result.body).to eq(body)
      expect(result.code).to eq(200)
    end
  end

  describe "#topic" do
    it "returns the specified topic by its topic key" do
      response_body = {
        key: "string",
        name: "string"
      }.to_json

      stub_request(:get, "#{base_uri}/topics/#{topic_key}")
        .to_return(status: 200, body: response_body)

      result = client.topic(topic_key)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#rename_topic" do
    it "rename a topic by providing a new name" do
      body = {
        name: "string"
      }.to_json

      response_body = {
        key: "string",
        name: "string"
      }.to_json

      stub_request(:patch, "#{base_uri}/topics/#{topic_key}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.rename_topic(topic_key, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_topic" do
    it "delete a topic by its topic key if it has no subscribers" do
      

      stub_request(:delete, "#{base_uri}/topics/#{topic_key}")
        .to_return(status: 204)

      result = client.delete_topic(topic_key)
      expect(result.code).to eq(204)
    end
  end
end
