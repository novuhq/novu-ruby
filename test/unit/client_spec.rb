# frozen_string_literal: true

require_relative "../../lib/novu"

describe Novu::Client do

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

  it "enables exponential retry mechanism" do
    client = Novu::Client.new(
      access_token: access_token, 
      idempotency_key: idempotency_key1, 
      enable_retry: true, 
      retry_config: { max_retries: 3 }
    )
    client.expects(:create_subscriber).returns(StandardError)

    result = client.create_subscriber(body)
    assert_equal(StandardError, result)
  end

  it "failed request not retried" do
    client = Novu::Client.new(access_token: access_token)
    client.expects(:create_subscriber).returns(status: 401)

    result = client.create_subscriber(body)
    assert_equal(401, result[:status])
  end

  it "performs idempotent request with no duplicate result" do

    client = Novu::Client.new(access_token: access_token, idempotency_key: idempotency_key2)
    client.expects(:create_subscriber).at_most(3).returns(status: 201, body: response_body)
    result1 = client.create_subscriber(body)
    result2 = client.create_subscriber(body)
    result3 = client.create_subscriber(body)

    assert_equal(result2[:body], result1[:body])
    assert_equal(result2[:body], result3[:body])
    assert_equal(result1[:body], result3[:body])
  end
end