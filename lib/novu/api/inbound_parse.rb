# frozen_string_literal: true

module Novu
  class Api
    module InboundParse
      def validate_mx_record_setup_for_inbound_parse
        get("/inbound-parse/mx/status")
      end
    end
  end
end
