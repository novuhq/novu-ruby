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

      def request(http_method, path, options)
        response = self.class.send(http_method, path, options)
        puts response.code
        if response.code < 500
          response
        elsif @enable_retry
          @retry_attempts += 1

          puts "retrying requests now....  #{@retry_attempts}"
    
          if @retry_attempts < @max_retries
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
