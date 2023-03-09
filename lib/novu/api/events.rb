# frozen_string_literal: true

module Novu
  class Api
    # Module Novu::Api::Events provides an API for managing events in the Novu application.
    #
    # This module includes methods for trigger, bulk trigger, broadcast and cancel events.
    #
    # For more information on the Novu API(https://api.novu.co/api#/Events), see https://docs.novu.co/api/trigger-event/.
    module Events
      # Trigger event is the main (and the only) way to send notification to subscribers.
      # The trigger identifier is used to match the particular template associated with it.
      # Additional information can be passed according the body interface below
      # 
      # @bodyparams:
      # @param `name` [String] The trigger identifier of the template you wish to send. This identifier can be found on the template page.
      # @param `payload` [Hash] The payload object is used to pass additional custom information that could be used to render the template, or perform routing rules based on it. This data will also be available when fetching the notifications feed from the API to display certain parts of the UI.
      # @param `overrides` [Hash(optional)] This could be used to override provider specific configurations.
      # @param `to` [Hash] The recipients list of people who will receive the notification.
      # @param `transactionId` [String(optional)] A unique identifier for this transaction, we will generated a UUID if not provided.
      # @param `actor` [Hash(optional)] It is used to display the Avatar of the provided actor's subscriber id or actor object. If a new actor object is provided, we will create a new subscriber in our system
      #
      # @return [Hash] 
      #   - acknowledged [Boolean] - If trigger was acknowledged or not
      #   - status [String] - Status for trigger
      #   - error [Array(optional)] - In case of an error, this field will contain the error message
      #   - transactionId [String(optional)] - Transaction id for trigger
      # @return [number] status - The status code. Returns 201 if the event has been successfully triggered.
      def trigger_event(body)
        post("/events/trigger", body: body)
      end

      # Using this endpoint you can trigger multiple events at once, to avoid multiple calls to the API.
      # The bulk API is limited to 100 events per request.
      # 
      # @bodyparams:
      # @param `events` [Array[event]]
      #     @event : event structure
      #     @param `name` [String] The trigger identifier of the template you wish to send. This identifier can be found on the template page.
      #     @param `payload` [Hash] The payload object is used to pass additional custom information that could be used to render the template, or perform routing rules based on it. This data will also be available when fetching the notifications feed from the API to display certain parts of the UI.
      #     @param `overrides` [Hash(optional)] This could be used to override provider specific configurations.
      #     @param `to` [Hash] The recipients list of people who will receive the notification.
      #     @param `transactionId` [String(optional)] A unique identifier for this transaction, we will generated a UUID if not provided.
      #     @param `actor` [Hash(optional)] It is used to display the Avatar of the provided actor's subscriber id or actor object. If a new actor object is provided, we will create a new subscriber in our system
      #
      # @return [Hash] 
      #   - acknowledged [Boolean] - If trigger was acknowledged or not
      #   - status [String] - Status for trigger
      #   - error [Array(optional)] - In case of an error, this field will contain the error message
      #   - transactionId [String(optional)] - Transaction id for trigger
      # @return [number] status - The status code. Returns 201 if the event has been successfully triggered.
      def trigger_bulk_event(body)
        post("/events/trigger/bulk", body: body)
      end

      # Trigger a broadcast event to all existing subscribers, could be used to send announcements, etc.
      # In the future could be used to trigger events to a subset of subscribers based on defined filters.
      #
      # @bodyparams:
      # @param `name` [String] The trigger identifier associated for the template you wish to send. This identifier can be found on the template page.
      # @param `payload` [Hash] The payload object is used to pass additional custom information that could be used to render the template, or perform routing rules based on it. This data will also be available when fetching the notifications feed from the API to display certain parts of the UI
      # @param `overrides` [Hash(optional)] This could be used to override provider specific configurations.
      # @param `transactionId` [String(optional)] A unique identifier for this transaction, we will generated a UUID if not provided.
      # @param `actor` [Hash(optional)] It is used to display the Avatar of the provided actor's subscriber id or actor object. If a new actor object is provided, we will create a new subscriber in our system
      #
      # @return [Hash] 
      #   - acknowledged [Boolean] - If trigger was acknowledged or not
      #   - status [String] - Status for trigger
      #   - error [Array(optional)] - In case of an error, this field will contain the error message
      #   - transactionId [String(optional)] - Transaction id for trigger
      # @return [number] status - The status code. Returns 201 if the event has been successfully broadcast to all existing subscribers.
      def broadcast_event(body)
        post("/events/trigger/broadcast", body: body)
      end

      # Using a previously generated transactionId during the event trigger, will cancel any active or pending workflows.
      # This is useful to cancel active digests, delays etc...
      #
      # @pathparams:
      # @param `transactionId` [String] - transaction id of the event
      #
      # @return [number] status - The status code. Returns 200 if the event has been successfully cancelled.
      def cancel_triggered_event(transaction_id)
        delete("/events/trigger/#{transaction_id}")
      end
    end
  end
end
