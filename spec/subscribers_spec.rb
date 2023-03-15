# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Subscribers do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:subscriber_id) { "63f71b3ef067290fa669106d" }

  describe "#subscribers" do
    context "when no query params are passed" do
      it "returns all subscribers" do
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

        stub_request(:get, "#{base_uri}/subscribers")
          .to_return(status: 200, body: response_body)

        result = client.subscribers

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end

    context "when the 'page' query param is passed" do
      it "returns the subscribers for the specified page" do
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

        stub_request(:get, "#{base_uri}/subscribers?page=2")
          .to_return(status: 200, body: response_body)

        result = client.subscribers(query_params)

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end
  end

  describe "#create_subscriber" do
    it "creates a new subscriber" do
      body = {
        firstName: "John",
        lastName: "Doe"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:post, "#{base_uri}/subscribers")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_subscriber(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#subscriber" do
    it "returns the specified subscriber" do

      response_body = {
        _id: subscriber_id,
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/subscribers/#{subscriber_id}")
        .to_return(status: 200, body: response_body)

      result = client.subscriber(subscriber_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_subscriber" do
    it "updates the specified subscriber" do
      body = {
        firstName: "John",
        lastName: "Doe"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:put, "#{base_uri}/subscribers/#{subscriber_id}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_subscriber(subscriber_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_subscriber" do
    it "deletes the specified subscriber" do
      response_body = {
        acknowledged: true,
        status: "deleted"
      }.to_json

      stub_request(:delete, "#{base_uri}/subscribers/#{subscriber_id}")
        .to_return(status: 200, body: response_body)

      result = client.delete_subscriber(subscriber_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_subscriber_credentials" do
    it "updates the subscriber credentials" do
      body = {
        providerId: "slack",
        credentials: { token: "new-slack-token" }
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:put, "#{base_uri}/subscribers/#{subscriber_id}/credentials")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_subscriber_credentials(subscriber_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_subscriber_online_status" do
    it "update subscriber online status" do
      body = {
        isOnline: true
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d",
        isOnline: true
      }.to_json

      stub_request(:patch, "#{base_uri}/subscribers/#{subscriber_id}/online-status")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_subscriber_online_status(subscriber_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#subscriber_preferences" do
    it "get the subscriber preferences" do
      response_body = {
        "preference": {
          "enabled": true
        }
      }.to_json

      stub_request(:get, "#{base_uri}/subscribers/#{subscriber_id}/preferences")
        .to_return(status: 200, body: response_body)

      result = client.subscriber_preferences(subscriber_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#update_subscriber_preference" do
    it "update subscriber preference" do
      template_id = "63g71b3fe067290af669106e"

      body = {
        providerId: "slack",
        credentials: { token: "new-slack-token" }
      }.to_json

      response_body = {
        "channel": {
          "type": "in_app",
          "enabled": true
        }
      }.to_json

      stub_request(:patch, "#{base_uri}/subscribers/#{subscriber_id}/preferences/#{template_id}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_subscriber_preference(subscriber_id, template_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#subscriber_notification_feed" do
    it "returns a notification feed for a particular subscriber" do
      query_params = { feedIdentifier: "test-feed" }

      response_body = {
        "feed": {}
      }.to_json

      stub_request(:get, "#{base_uri}/subscribers/#{subscriber_id}/notifications/feed?feedIdentifier=test-feed")
        .to_return(status: 200, body: response_body)

      result = client.subscriber_notification_feed(subscriber_id, query_params)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#subscriber_unseen_notification_count" do
    it "returns the unseen notification count for subscribers feed" do
      query_params = { seen: "true" }

      response_body = {
        count: 0
      }.to_json

      stub_request(:get, "#{base_uri}/subscribers/#{subscriber_id}/notifications/unseen?seen=true")
        .to_return(status: 200, body: response_body)

      result = client.subscriber_unseen_notification_count(subscriber_id, query_params)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#mark_subscriber_feed_seen" do
    it "mark a subscriber feed message as seen" do
      body = {
        messageId: "string",
        mark: {
          seen: true,
          read: true
        }
      }.to_json

      response_body = {
        channel: "in_app",
        seen: true
      }.to_json

      stub_request(:post, "#{base_uri}/subscribers/#{subscriber_id}/messages/markAs")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.mark_subscriber_feed_seen(subscriber_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#mark_message_action_seen" do
    it "mark message action as seen" do
      message_id = "212"
      type = "email"
      response_body = {
        action: true,
        seen: true
      }.to_json

      stub_request(:post, "#{base_uri}/subscribers/#{subscriber_id}/messages/#{message_id}/actions/#{type}")
        .to_return(status: 201, body: response_body)

      result = client.mark_message_action_seen(subscriber_id, message_id, type)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end
end
