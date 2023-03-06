# frozen_string_literal: true

module Novu
  class Api
    module Changes
      def changes(query = {})
        get("/changes", query: query)
      end

      def count_changes
        get("/changes/count")
      end

      def apply_bulk_changes
        post("/changes/bulk/apply")
      end

      def apply_change(change_id)
        post("/changes/#{change_id}/apply")
      end
    end
  end
end
