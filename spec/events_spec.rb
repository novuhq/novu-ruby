# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Events do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#trigger_event" do
    it "triggers an event" do
      body = {
        name: "welcome",
        payload: { message: "Hello, world!" },
        to: { email: "user@example.com" }
      }.to_json

      response_body = {
        acknowledged: true,
        status: "processed",
        error: [
          "string"
        ],
        transactionId: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/events/trigger")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.trigger_event(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#trigger_bulk_event" do
    it "triggers multiple events with valid parameters" do
      body = {
        events: [
          {
            name: "welcome",
            payload: { message: "Hello, user1!" },
            to: { email: "user1@example.com" }
          },
          {
            name: "welcome",
            payload: { message: "Hello, user2!" },
            to: { email: "user2@example.com" }
          }
        ]
      }

      response_body = {
        acknowledged: true,
        status: "processed",
        error: [
          "string"
        ],
        transactionId: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/events/trigger/bulk")
        .with(body: body).to_return(status: 201, body: response_body)

      result = client.trigger_bulk_event(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#trigger_broadcast_event" do
    it "triggers a broadcast event with valid parameters" do
      body = {
        name: "announcement",
        payload: { message: "Important announcement!" }
      }.to_json

      response_body = {
        acknowledged: true,
        status: "processed",
        error: [
          "string"
        ],
        transactionId: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/events/trigger/broadcast")
        .with(body: body).to_return(status: 201, body: response_body)

      result = client.broadcast_event(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#cancel_triggered_event" do
    it "triggers to cancel event with valid transactionId" do
      transaction_id = "63f731fb0c5d5e4967c52775"

      response_body = {
        acknowledged: true
      }.to_json

      stub_request(:delete, "#{base_uri}/events/trigger/#{transaction_id}")
        .to_return(status: 200, body: response_body)

      result = client.cancel_triggered_event(transaction_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
