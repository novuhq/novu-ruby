# frozen_string_literal: true

module Novu
  class Api
    module Notification
      def notifications(options = {})
        get("/notifications", options)
      end
      
    end
  end
end
