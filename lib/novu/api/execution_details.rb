# frozen_string_literal: true

module Novu
  class Api
    module ExecutionDetails
      def execution_details(query = {})
        get("/execution-details", query: query)
      end
    end
  end
end
