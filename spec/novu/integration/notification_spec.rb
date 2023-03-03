# require 'spec_helper'
# require 'novu/api/notification'

# describe Novu::Api::Notification do
#   let(:dummy_class) { Class.new { extend Novu::Api::Notification } }

#   describe '#notifications' do
#     context 'when no options are passed' do
#       it 'sends a GET request to /notifications' do
#         expect(dummy_class).to receive(:get).with('/notifications', {})
#         dummy_class.notifications
#       end
#     end

#     context 'when options are passed' do
#       it 'sends a GET request to /notifications with the options' do
#         options = { foo: 'bar', baz: 'qux' }
#         expect(dummy_class).to receive(:get).with('/notifications', options)
#         dummy_class.notifications(options)
#       end
#     end
#   end



# end
