# frozen_string_literal: true

require_relative "../lib/novu"

RSpec.describe Novu::Api::Messages do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#message" do
    it "returns a list of messages " do
      response_body = {
        _id: "message_id",
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/messages")
        .to_return(status: 200, body: response_body)

      result = client.messages

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_message" do
    it "deletes the specified message" do
      message_id = "12345"
      response_body = {
        acknowledged: true,
        status: "deleted"
      }.to_json

      stub_request(:delete, "#{base_uri}/messages/#{message_id}")
        .to_return(status: 200, body: response_body)

      result = client.delete_message(message_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
