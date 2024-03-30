# frozen_string_literal: true

require_relative "../lib/novu"

RSpec.describe Novu::Client do

  let(:access_token) { "1234567890" }
  let(:idempotency_key1) { "489e2e70-50be-013c-faf9-38e85644422a" }
  let(:idempotency_key2) { "99893-50be-5d3c-k109-8920564sd22a" }

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
  let(:failure_response) { TestResponse.new(code: 401) }
  let(:success_response) { TestResponse.new(code: 201) }

  context "with exponential retry enabled" do
    let(:client) {
      Novu::Client.new(
        access_token: access_token,
        idempotency_key: idempotency_key1,
        enable_retry: true,
        retry_config: {
          max_retries: max_retries,
          initial_delay: 0,
          max_delay: 0
        }
    )}

    context "when all retries fail" do
      before do
        allow(Novu::Client).to receive(:post).and_return(failure_response)
      end
      it "throws an error" do
        expect { client.create_subscriber(body) }.to raise_error(StandardError)
      end
    end

    context "as soon as a request succeeds" do
      before do
        allow(Novu::Client).to receive(:post).and_return(success_response)
      end

      it "should return successfully" do
        result = client.create_subscriber(body)
        expect(result[:status]).to eq(201)
      end
    end

  end

  it "failed request not retried" do
    client = Novu::Client.new(access_token: access_token)
    allow(client).to receive(:request).and_return(status: 401)

    result = client.create_subscriber(body)
    expect(result[:status]).to eq(401)
  end

  it "performs idempotent request with no duplicate result" do
    client = Novu::Client.new(access_token: access_token, idempotency_key: idempotency_key2)
    allow(client).to receive(:request).at_most(max_retries).and_return(status: 201, body: response_body)
    result1 = client.create_subscriber(body)
    result2 = client.create_subscriber(body)
    result3 = client.create_subscriber(body)

    expect(result1[:body]).to eq(response_body)
    expect(result2[:body]).to eq(response_body)
    expect(result3[:body]).to eq(response_body)
  end
end

class TestResponse
  attr_accessor :code

  def initialize(code)
    @code = code
  end
end
