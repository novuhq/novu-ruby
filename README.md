# Novu ruby client library

This is a Ruby client library for communicating with the [Novu API](https://api.novu.co/api).

## Installation

You can install the client library via RubyGems:

```ruby
gem install novu
```

Or add it to your Gemfile:

```ruby
gem 'novu'
```

Then run `bundle install`.

## Usage

To use the library, first initialize the client with your API token:

```ruby
require 'novu'

client = Novu::Client.new('MY_API_TOKEN')
```

If you are using a self-hosted instance of Novu, you can initialize the client with your API token and the URL where your instance is hosted:

```ruby
require 'novu'

client = Novu::Client.new('MY_API_TOKEN', 'http://your-novu-instance')
```

You can then call methods on the client to interact with the Novu API:

```ruby
client.notifications
```

## List of all methods

The client methods map directly to the Novu API endpoints. Here's a list of all the available methods. Check [the API docs](https://docs.novu.co/api/overview) for list of available `methods`.

### Changes

- `changes(query = {})`
- `count_changes()`
- `apply_bulk_changes()`
- `apply_change(change_id)`

### Environments

- `current_environment()`
- `create_environment(body)`
- `environments()`
- `update_environment(environment_id, body)`
- `api_keys()`
- `regenerate_api_keys()`
- `update_widget_settings(body)`

### Events

- `trigger_event(body)`
- `trigger_bulk_event(body)`
- `broadcast_event(body)`
- `cancel_triggered_event(transaction_id)`

### Execution Details

- `execution_details(query = {})`

### Feeds

- `create_feed(body)`
- `feeds()`
- `delete_feed(feed_id)`

### Inbound Parse

- `validate_mx_record_setup_for_inbound_parse()`

### Integrations

- `integrations()`
- `create_integration(body)`
- `active_integrations()`
- `webhook_provider_status(provider_id)`
- `update_integration(integration_id, body)`
- `delete_integration(integration_id)`
- `channel_limit(channel_type)`
- `in_app_status()`

### Layouts

- `create_layout(body) `
- `layouts(query = {})`
- `layout(layout_id)`
- `delete_layout(layout_id)`
- `update_layout(layout_id, body)`
- `make_default_layout(layout_id)`

### Messages

- `messages(query = {})`
- `delete_message(message_id)`

### Notification Groups

- `create_notification_group(body)`
- `notification_groups()`

### Notification Templates

- `notification_templates(query = {})`
- `create_notification_template(body)`
- `update_notification_template(template_id, body)`
- `delete_notification_template(template_id)`
- `notification_template(template_id)`
- `notification_template_blueprint(template_id)`
- `create_notification_template_blueprint(template_id)`
- `update_notification_template_status(template_id, body)`

### Notification

- `notifications(query = {})`
- `notifications_stats()`
- `notifications_graph_stats(query = {})`
- `notification(notification_id)`

### Subscribers

- `subscribers(query = {}) `
- `create_subscriber(body)`
- `subscriber(subscriber_id)`
- `update_subscriber(subscriber_id, body)`
- `delete_subscriber(subscriber_id)`
- `update_subscriber_credentials(subscriber_id, body)`
- `update_subscriber_online_status(subscriber_id, body)`
- `subscriber_preferences(subscriber_id)`
- `update_subscriber_preference(subscriber_id, template_id, body)`
- `subscriber_notification_feed(subscriber_id, query = {})`
- `subscriber_unseen_notification_count(subscriber_id, query = {})`
- `mark_subscriber_feed_seen(subscriber_id, body)`
- `mark_message_action_seen(subscriber_id, message_id, type)`

### Topics

- `create_topic(body)`
- `topics(query = {})`
- `add_subscribers(topic_key, body)`
- `remove_subscribers(topic_key, body)`
- `topic(topic_key)`
- `rename_topic(topic_key, body)`

### For more information about these methods and their parameters, see the [API documentation](https://docs.novu.co/api/overview).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/novuhq/novu-ruby
