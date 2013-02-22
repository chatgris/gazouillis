# gazouillis

Gazouillis aims to be a fast and reliable twitter stream client.

## Status

Very early stage. Not ready for production.

## Usage

Connection to twitter's userstream:

``` ruby
require 'gazouillis'

class Timeline < Gazouillis::UserStream
  def on_message(message)
    # Do something with streamed message
    #
    # Parse message, and outputs.
    #
    p MultiJson.decode message
  end
end

options = {
  oauth: {
    consumer_key:    "consumer_key",
    consumer_secret: "consumer_secret",
    token:           "token",
    token_secret:    "token_secret"
  }
}

Timeline.new(options).open
```

Or be barbone, and use the internal class.

``` ruby
require 'gazouillis'

class Tweets < Gazouillis::Stream
  def on_message(message)
    # Do something with streamed message
    #
    # Parse message, and outputs.
    #
    p MultiJson.decode message
  end
end

options = {
  oauth: {
    consumer_key:    "consumer_key",
    consumer_secret: "consumer_secret",
    token:           "token",
    token_secret:    "token_secret"
  }
}

Tweets.new('/1/statuses/sample.json', options).async.open
```

Gazouillis relies on [Celluloid::IO](https://github.com/celluloid/celluloid-io).
Hence the `async` capability.

## Roadmap

### 0.2.0

  * UserStream, FilterStream and SampleStream

### 0.3.0

  * Reconnector object.

## Copyright

MIT. See LICENSE for further details.
