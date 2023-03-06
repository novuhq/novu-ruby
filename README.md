### Novu ruby client library

<!-- [![Build Status](https://travis-ci.org/Fodoj/groovehq.svg)](https://travis-ci.org/Fodoj/groovehq) -->

Client library for talking to [Novu API](https://docs.novu.co/api/overview/).

#### Usage

First of all, initialize client:

```ruby
client = Novu::Client.new("MY_API_TOKEN")
```

And then talk to API:

```ruby
client.notifications
```

#### List of all methods

Client methods really just map 1 to 1 to API, see all of them beyond. Check [the API docs](https://docs.novu.co/api/overview) for list of available `options`.
