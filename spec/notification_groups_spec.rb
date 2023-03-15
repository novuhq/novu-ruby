# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::NotificationGroups do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#create_notification_group" do
    it "creates a new notification group" do
      body = {
        name: "string"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:post, "#{base_uri}/notification-groups")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_notification_group(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#notification_groups" do
    it "returns a list of notification groups" do
      response_body = {
        _id: "63f71b3ef067290fa669106d",
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/notification-groups")
        .to_return(status: 200, body: response_body)

      result = client.notification_groups

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
