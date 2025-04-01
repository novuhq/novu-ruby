# frozen_string_literal: true

module Novu
  class Api
    module Connection

      def get(path, options = {})
        request :get, path, options
      end

      def post(path, options = {})
        request :post, path, options
      end

      def put(path, options = {})
        request :put, path, options
      end

      def patch(path, options = {})
        request :patch, path, options
      end

      def delete(path, options = {})
        request :delete, path, options
      end

      private

      # Send API Request
      #
      # It applies exponential backoff strategy (if enabled) for failed requests. 
      # It also performs an idempotent request to safely retry requests without having duplication operations.
      #
      def request(http_method, path, options, retry_number: 0)
        raise StandardError, "Max retry attempts reached" if retry_number >= @max_retries

        if http_method.to_s == 'post' || http_method.to_s == 'patch'
          self.class.default_options[:headers].merge!({ "Idempotency-Key" => "#{@idempotency_key.to_s.strip}"  }) 
        end

        response = self.class.send(http_method, path, options)

        if ! [500, 502, 503, 504].include?(response.code) || ! @enable_retry
          response
        else
          sleep(@backoff.interval_at(retry_number))
          request(http_method, path, options, retry_number: retry_number + 1)
        end
      end
    end
  end
end
