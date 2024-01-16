# frozen_string_literal: true

require_relative "../lib/novu"

RSpec.describe Novu::Api::Organizations do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:topic_key) { "test-topic" }

  describe "#create_organization" do
    it "creates an organization" do
			body = {
        logo: "string",
        name: "string"
      }.to_json

      response_body = {}.to_json

      stub_request(:post, "#{base_uri}/organizations")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.create_organization(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
	end

	describe "#organizations" do
    it "get all organizations" do

			response_body = {
				data: [
					{
						name: "string",
						logo: "string",
						branding: {}
					}
				]
			}.to_json
      stub_request(:get, "#{base_uri}/organizations")
        .to_return(status: 200, body: response_body)

      result = client.organizations()

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
	end

	describe "#current_organization" do
    it "get details of the current organization" do

			response_body = {
				data: [
					{
						name: "string",
						logo: "string",
						branding: {}
					}
				]
			}.to_json
      stub_request(:get, "#{base_uri}/organizations/me")
        .to_return(status: 200, body: response_body)

      result = client.current_organization()

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
	end

	describe "#rename_organization" do
    it "rename organization name" do
			body = {
				name: "new organization name"
			}

			response_body = {
				data:{
						name: "new organization name",
					}
			}.to_json
      stub_request(:patch, "#{base_uri}/organizations")
        .to_return(status: 200, body: response_body)

      result = client.rename_organization(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
	end
	
	describe "#organization_branding" do
		it "update organization branding details" do
			body = {
				fontColor: 'ffffff', 
				fontFamily: 'Helvetica', 
				logo: 'https://via.placeholder.com/640x480.png', 
				contentBackground: 'ffffff'
			}

			response_body = {
				data:{
					fontColor: 'ffffff', 
					fontFamily: 'Helvetica', 
					logo: 'https://via.placeholder.com/640x480.png', 
					contentBackground: 'ffffff'
				}
			}.to_json
			stub_request(:put, "#{base_uri}/organizations/branding")
				.to_return(status: 200, body: response_body)

			result = client.organization_branding(body)

			expect(result.body).to eq(response_body)
			expect(result.code).to eq(200)
		end
	end

	describe "#delete_organization_member" do
		it "remove a member from an organization" do
			response_body = {}.to_json
			stub_request(:delete, "#{base_uri}/organizations/members/123")
				.to_return(status: 200, body: response_body)

			result = client.delete_organization_member('123')

			expect(result.body).to eq(response_body)
			expect(result.code).to eq(200)
		end
	end
end