# frozen_string_literal: true

module Novu
    class Api
      module Environments
        def current_environment
          get("/environments/me")
        end

        def create_environment(body)
          post("/environments", body: body)
        end

        def environments
          get("/environments")
        end
        
        def update_environment(environment_id, body)
          put("/environments/#{environment_id}", body: body)
        end
        
        def api_keys
          get("/environments/api-keys")
        end
  
        def regenerate_api_keys
          post("/environments/api-keys/regenerate")
        end

        def update_widget_settings(body)
          put("/environments/widget/settings", body: body)
        end
      end
    end
  end
  