# frozen_string_literal: true

require_relative "../lib/novu"

RSpec.describe Novu::Api::Changes do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }

  describe "#changes" do
    it "returns list of changes" do
      query_params = { promoted: true }
      response_body = {
        "page": 2,
        "totalCount": 12,
        "pageSize": 10,
        "data": [
          {
            "_id": "string"
          }
        ]
      }.to_json

      stub_request(:get, "#{base_uri}/changes?promoted=true")
        .to_return(status: 200, body: response_body)

      result = client.changes(query_params)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#change" do
    it "returns changes count" do
      response_body = 0.to_json

      stub_request(:get, "#{base_uri}/changes/count")
        .to_return(status: 200, body: response_body)

      result = client.count_changes

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#apply_bulk_changes" do
    it "apply bulk change" do
      payload = {
        'changeIds' => ['string']
      }

      response_body = {
        _id: "string",
        _creatorId: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/changes/bulk/apply")
        .to_return(status: 201, body: response_body)

      result = client.apply_bulk_changes(payload)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#apply_change" do
    it "apply change" do
      change_id = "212"

      response_body = {
        _id: "string",
        _creatorId: "string"
      }.to_json

      stub_request(:post, "#{base_uri}/changes/#{change_id}/apply")
        .to_return(status: 201, body: response_body)

      result = client.apply_change(change_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end
end
