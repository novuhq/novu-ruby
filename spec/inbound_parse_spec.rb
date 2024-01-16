# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::InboundParse do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:subscriber_id) { "63f71b3ef067290fa669106d" }

  describe "#validate_mx_record_setup_for_inbound_parse" do
    it "validate the mx record setup for the inbound parse functionality" do
      response_body = {
        mxRecordConfigured: true
      }.to_json

      stub_request(:get, "#{base_uri}/inbound-parse/mx/status")
        .to_return(status: 200, body: response_body)

      result = client.validate_mx_record_setup_for_inbound_parse

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
