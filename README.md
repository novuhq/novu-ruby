### Novu ruby client library

<!-- [![Build Status](https://travis-ci.org/Fodoj/groovehq.svg)](https://travis-ci.org/Fodoj/groovehq) -->

Client library for talking to [Novu API](https://api.novu.co/api).

#### Usage

First of all, initialize client:

```ruby
bundle exec irb
require "./lib/novu.rb"
client = Novu::Client.new("MY_API_TOKEN")
```

And then talk to API:

```ruby
client.notifications
```

#### List of all methods

Client methods really just map 1 to 1 to API, see all of them beyond. Check [the API docs](https://docs.novu.co/api/overview) for list of available `options`.
