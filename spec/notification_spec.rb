require 'spec_helper'
require_relative "../lib/novu"

RSpec.describe Novu::Api::Notification do
  let(:api) { Novu::Api::Notification.new }

  describe '#notifications' do
    let(:query_params) { { channels: ['email'], templates: ['welcome'], page: 1 } }
    let(:response_body) { { notifications: [{ id: 1, message: 'Welcome to Novu!' }] } }

    it 'returns a list of notifications' do
      stub_request(:get, 'https://api.novu.co/notifications?page=1&channels%5B%5D=email&templates%5B%5D=welcome')
        .to_return(status: 200, body: response_body.to_json)

      result = api.notifications(query_params)

      expect(result[:notifications]).to eq(response_body[:notifications])
      expect(result[:status]).to eq(200)
    endsp
  end

  describe '#notifications_stats' do
    let(:response_body) { { count: 10, total: 100 } }

    it 'returns notification stats' do
      stub_request(:get, 'https://api.novu.co/notifications/stats')
        .to_return(status: 200, body: response_body.to_json)

      result = api.notifications_stats

      expect(result[:count]).to eq(response_body[:count])
      expect(result[:total]).to eq(response_body[:total])
      expect(result[:status]).to eq(200)
    end
  end

  describe '#notifications_graph_stats' do
    let(:query_params) { { days: 7 } }
    let(:response_body) { { data: [1, 2, 3, 4, 5] } }

    it 'returns notification graph stats' do
      stub_request(:get, 'https://api.novu.co/notifications/graph/stats?days=7')
        .to_return(status: 200, body: response_body.to_json)

      result = api.notifications_graph_stats(query_params)

      expect(result[:data]).to eq(response_body[:data])
      expect(result[:status]).to eq(200)
    end
  end

  describe '#notification' do
    let(:notification_id) { 'abc123' }
    let(:response_body) { { id: notification_id, message: 'Hello World!' } }

    it 'returns a single notification' do
      stub_request(:get, "https://api.novu.co/notifications/#{notification_id}")
        .to_return(status: 200, body: response_body.to_json)

      result = api.notification(notification_id)

      expect(result[:id]).to eq(notification_id)
      expect(result[:message]).to eq(response_body[:message])
      expect(result[:status]).to eq(200)
    end
  end
end





