# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Subscribers do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#execution_details" do
    it "returns a list of execution details" do
      query_params = { notificationId: "2212", subscriberId: "4114" }

      response_body = {
        _id: "4114",
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/execution-details?notificationId=2212&subscriberId=4114")
        .to_return(status: 200, body: response_body)

      result = client.execution_details(query_params)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
