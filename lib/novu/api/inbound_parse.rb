# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::InboundParse provides an API for managing inbound-parse in the Novu application.
    #
    # This module includes method for retrieving inbound-parse.
    #
    # For more information on the Novu API(https://api.novu.co/api#/inbound-parse), see https://docs.novu.co/api/overview/.
    module InboundParse
      # Validate the mx record setup for the inbound parse functionality
      def validate_mx_record_setup_for_inbound_parse
        get("/inbound-parse/mx/status")
      end
    end
  end
end
