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
      def request(http_method, path, options)

        if http_method.to_s == 'post' || http_method.to_s == 'patch'
          self.class.default_options[:headers].merge!({ "Idempotency-Key" => "#{@idempotency_key.to_s.strip}"  }) 
        end

        response = self.class.send(http_method, path, options)

        if  ! [401, 403, 409, 500, 502, 503, 504].include?(response.code) && ! @enable_retry
          response
        elsif @enable_retry
    
          if @retry_attempts < @max_retries
            @retry_attempts += 1

            @backoff.intervals.each do |interval|
              sleep(interval)
              request(http_method, path, options)
            end
          else
            raise StandardError, "Max retry attempts reached"
          end
        else
          response
        end
      end
    end
  end
end
