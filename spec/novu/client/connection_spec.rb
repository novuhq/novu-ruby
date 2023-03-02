require 'spec_helper'

describe Novu::Api::Connection do
  let(:connection) { Class.new { extend Novu::Api::Connection } }

  describe '#get' do
    it 'sends a GET request' do
      expect(connection).to receive(:request).with(:get, '/path', {})
      connection.get('/path')
    end

    it 'sends a GET request with options' do
      expect(connection).to receive(:request).with(:get, '/path', {param: 'value'})
      connection.get('/path', {param: 'value'})
    end
  end

  describe '#post' do
    it 'sends a POST request' do
      expect(connection).to receive(:request).with(:post, '/path', {})
      connection.post('/path')
    end

    it 'sends a POST request with options' do
      expect(connection).to receive(:request).with(:post, '/path', {param: 'value'})
      connection.post('/path', {param: 'value'})
    end
  end

  describe '#put' do
    it 'sends a PUT request' do
      expect(connection).to receive(:request).with(:put, '/path', {})
      connection.put('/path')
    end

    it 'sends a PUT request with options' do
      expect(connection).to receive(:request).with(:put, '/path', {param: 'value'})
      connection.put('/path', {param: 'value'})
    end
  end

  describe '#delete' do
    it 'sends a DELETE request' do
      expect(connection).to receive(:request).with(:delete, '/path', {})
      connection.delete('/path')
    end

    it 'sends a DELETE request with options' do
      expect(connection).to receive(:request).with(:delete, '/path', {param: 'value'})
      connection.delete('/path', {param: 'value'})
    end
  end

  describe '#request' do
    let(:http_method) { :get }
    let(:path) { '/path' }
    let(:options) { {param: 'value'} }
    let(:response) { double(parsed_response: {}) }

    before do
      allow(connection.class).to receive(:send).with(http_method, path, {body: options}).and_return(response)
    end

    it 'sends a request and returns parsed response' do
      expect(connection.send(:request, http_method, path, options)).to eq({})
    end
  end
end
