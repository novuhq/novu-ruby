# frozen_string_literal: true

module Novu
  class Api
    module Subscribers
        def subscribers(options = {})
            get(/subscribers, options)
        end    
    end
  end
end
