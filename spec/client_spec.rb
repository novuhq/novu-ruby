# frozen_string_literal: true

require_relative "../lib/novu"

RSpec.describe Novu::Client do

  let(:access_token) { "1234567890" }
  let(:idempotency_key) { "489e2e70-50be-013c-faf9-38e85644422a" }

  let(:body) {
    {
      firstName: "John",
      lastName: "Doe"
    }.to_json
  }

  let(:response_body) {
    {
      _id: "63f71b3ef067290fa669106d"
    }.to_json
  }

  let(:max_retries) { 3 }
  let(:success_response) { TestResponse.new(code: 201, body: response_body) }
  let(:failure_response) { TestResponse.new(code: 500, body: response_body) }

  context "with exponential retry enabled" do
    let(:client) {
      Novu::Client.new(
        access_token: access_token,
        idempotency_key: idempotency_key,
        enable_retry: true,
        retry_config: {
          max_retries: max_retries,
          initial_delay: 0,
          max_delay: 0
        }
    )}

    context "when all retries fail" do
      before do
        allow(Novu::Client).to receive(:post).exactly(max_retries).and_return(failure_response)
      end
      it "throws an error" do
        expect { client.create_subscriber(body) }.to raise_error(StandardError)
      end
    end

    context "as soon as a request succeeds" do
      before do
        allow(Novu::Client).to receive(:post).at_most(2).and_return(failure_response, success_response)
      end

      it "should return successfully" do
        result = client.create_subscriber(body)
        expect(result[:status]).to eq(201)
      end
    end

  end

  context "with exponential retry disabled" do
    let(:client) { Novu::Client.new(access_token: access_token, idempotency_key: idempotency_key) }

    it "failed requests are not retried" do
      allow(Novu::Client).to receive(:post).exactly(1).and_return(failure_response)

      result = client.create_subscriber(body)
      expect(result[:status]).to eq(500)
    end

    it "performs idempotent request with no duplicate result" do
      allow(client).to receive(:request).at_most(3).and_return(success_response)
      result1 = client.create_subscriber(body)
      result2 = client.create_subscriber(body)
      result3 = client.create_subscriber(body)

      expect(result1[:body]).to eq(response_body)
      expect(result2[:body]).to eq(response_body)
      expect(result3[:body]).to eq(response_body)
    end
  end

end

class TestResponse
  attr_accessor :code, :body

  def initialize(code: 201, body: "")
    @code = code
    @body = body
  end

  def [](attr)
    attr == :status ? code : body
  end
end
