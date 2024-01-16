# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/novu"

RSpec.describe Novu::Api::NotificationTemplates do
  let(:access_token) { "1234567890" }
  let(:client) { Novu::Client.new(access_token: access_token) }
  let(:base_uri) { "https://api.novu.co/v1" }
  let(:template_id) { "63f71b3ef067290fa669106d" }

  describe "#notification_templates" do
    context "when no query params are passed" do
      it "returns all notification_templates" do
        response_body = {
          "page": 0,
          "totalCount": 2,
          "pageSize": 10,
          "data": [
            {
              "_id": "63f71b3ef067290fa669106d"
            }
          ]
        }.to_json

        stub_request(:get, "#{base_uri}/notification-templates")
          .to_return(status: 200, body: response_body)

        result = client.notification_templates

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end

    context "when the 'page' query param is passed" do
      it "returns the notification_templates for the specified page" do
        query_params = { page: 2 }
        response_body = {
          "page": 2,
          "totalCount": 12,
          "pageSize": 10,
          "data": [
            {
              "_id": "63f71b3ef067290fa669106d"
            }
          ]
        }.to_json

        stub_request(:get, "#{base_uri}/notification-templates?page=2")
          .to_return(status: 200, body: response_body)

        result = client.notification_templates(query_params)

        expect(result.body).to eq(response_body)
        expect(result.code).to eq(200)
      end
    end
  end

  describe "#create_notification_template" do
    it "creates a new notification template" do
      body = {
        name: "string",
        notificationGroupId: "string"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:post, "#{base_uri}/notification-templates")
        .with(body: body)
        .to_return(status: 201, body: response_body)

      result = client.create_notification_template(body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(201)
    end
  end

  describe "#update_notification_template" do
    it "updates the specified notification template" do
      body = {
        name: "string",
        description: "string"
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:put, "#{base_uri}/notification-templates/#{template_id}")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_notification_template(template_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#delete_notification_template" do
    it "deletes the specified notification template" do
      response_body = {
        acknowledged: true
      }.to_json

      stub_request(:delete, "#{base_uri}/notification-templates/#{template_id}")
        .to_return(status: 200, body: response_body)

      result = client.delete_notification_template(template_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#notification_template" do
    it "returns the specified notification template" do
      response_body = {
        _id: template_id,
        name: "John"
      }.to_json

      stub_request(:get, "#{base_uri}/notification-templates/#{template_id}")
        .to_return(status: 200, body: response_body)

      result = client.notification_template(template_id)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end

  describe "#notification_template_blueprint" do
    it "returns the notification template blueprint with the given ID." do
      stub_request(:get, "#{base_uri}/notification-templates/#{template_id}/blueprint")
        .to_return(status: 200)

      result = client.notification_template_blueprint(template_id)

      expect(result.code).to eq(200)
    end
  end

  describe "#create_notification_template_blueprint" do
    it "creates a new notification template blueprint." do
      stub_request(:post, "#{base_uri}/notification-templates/#{template_id}/blueprint")
        .to_return(status: 201)

      result = client.create_notification_template_blueprint(template_id)

      expect(result.code).to eq(201)
    end
  end

  describe "#update_notification_template_status" do
    it "update notification template status" do
      body = {
        active: true
      }.to_json

      response_body = {
        _id: "63f71b3ef067290fa669106d"
      }.to_json

      stub_request(:put, "#{base_uri}/notification-templates/#{template_id}/status")
        .with(body: body)
        .to_return(status: 200, body: response_body)

      result = client.update_notification_template_status(template_id, body)

      expect(result.body).to eq(response_body)
      expect(result.code).to eq(200)
    end
  end
end
