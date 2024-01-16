# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Notification do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#notifications" do
    let(:query_params) { { channels: ["email"], templates: ["63f731fb0c5d5e4967c52775"], page: 0 } }
    let(:response_body) { { notifications: [{ id: 1, message: "Welcome to Novu!" }] } }

    it "returns a list of notifications" do
      stub_request(:get, "#{base_uri}/notifications?channels%5B%5D=email&page=0&templates%5B%5D=63f731fb0c5d5e4967c52775")
        .to_return(status: 200, body: response_body.to_json)

      result = client.notifications(query_params)

      expect(result.body).to eq(response_body.to_json)
      expect(result.code).to eq(200)
    end
  end

  describe "#notifications_stats" do
    let(:response_body) { { "data": { "weeklySent": 0, "monthlySent": 3, "yearlySent": 3 } } }

    it "returns notification stats" do
      stub_request(:get, "#{base_uri}/notifications/stats")
        .to_return(status: 200, body: response_body.to_json)

      result = client.notifications_stats

      expect(result.body).to eq(response_body.to_json)
      expect(result.code).to eq(200)
    end
  end

  describe "#notifications_graph_stats" do
    let(:query_params) { { days: 7 } }
    let(:response_body) { { data: [1, 2, 3, 4, 5] } }

    it "returns notification graph stats" do
      stub_request(:get, "#{base_uri}/notifications/graph/stats?days=7")
        .to_return(status: 200, body: response_body.to_json)

      result = client.notifications_graph_stats(query_params)

      expect(result.body).to eq(response_body.to_json)
      expect(result.code).to eq(200)
    end
  end

  describe "#notification" do
    let(:notification_id) { "abc123" }
    let(:response_body) { { id: notification_id, message: "Hello World!" } }

    it "returns a single notification" do
      stub_request(:get, "#{base_uri}/notifications/#{notification_id}")
        .to_return(status: 200, body: response_body.to_json)

      result = client.notification(notification_id)

      expect(result.body).to eq(response_body.to_json)
      expect(result.code).to eq(200)
    end
  end
end
