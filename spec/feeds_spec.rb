# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Feeds do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#create_feed" do
    it "creates a new feed" do
      body = {
        name: "feed"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:post, "#{base_uri}/feeds")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_feed(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#feeds" do
    it "returns the feeds" do
      response_body = {
        _id: "feed_id",
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/feeds")
        .to_return(status: 200, body: response_body)

      result = client.feeds

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_feed" do
    it "deletes the specified feed" do
      feed_id = "63f71b3ef067290fa669106d"
      response_body = {
        _id: "string",
        name: "string"
      }.to_json

      stub_request(:delete, "#{base_uri}/feeds/#{feed_id}")
        .to_return(status: 200, body: response_body)

      result = client.delete_feed(feed_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
