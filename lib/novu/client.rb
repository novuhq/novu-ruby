module Novu

    class Client
        include HTTParty
        # include GrooveHQ::Client::Connection
        # include GrooveHQ::Client::Agents
        # include GrooveHQ::Client::Customers
        # include GrooveHQ::Client::Folders
        # include GrooveHQ::Client::Groups
        # include GrooveHQ::Client::Mailboxes
        # include GrooveHQ::Client::Attachments
        # include GrooveHQ::Client::Messages
        # include GrooveHQ::Client::Tickets
        # include GrooveHQ::Client::Webhooks
    
        base_uri "https://api.novu.co/v1"
        format :json
    
        def initialize(access_token = nil)
          access_token ||= ENV["NOVU_ACCESS_TOKEN"]
          self.class.default_options.merge!(headers: { 'Authorization' => "ApiKey #{access_token}" })
        end
    
    end
  
end