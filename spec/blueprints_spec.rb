# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::Blueprints do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#get_blueprint" do
    it "returns the details of a particular template " do
      template_id = "12345"

      response_body = {
        _id: "template_id"
      }.to_json

      stub_request(:get, "#{base_uri}/blueprints/#{template_id}")
        .to_return(status: 200, body: response_body)

      result = client.get_blueprint(template_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#group_blueprints_by_category" do
    it "return blueprints and group by category" do
      message_id = "12345"
      response_body = {
          "general": [
            "object"
          ],
          "popular": "object"
      }.to_json

      stub_request(:get, "#{base_uri}/blueprints/group-by-category")
        .to_return(status: 200, body: response_body)

      result = client.group_blueprints_by_category()

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
