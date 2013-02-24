# gazouillis

[![Code
Climate](https://codeclimate.com/github/chatgris/gazouillis.png)](https://codeclimate.com/github/chatgris/gazouillis)
[![Gem
Version](https://badge.fury.io/rb/gazouillis.png)](http://badge.fury.io/rb/gazouillis)

Gazouillis aims to be a fast and reliable twitter stream client.

## Status

Very early stage. Not ready for production.

## Usage

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

Tweets.new('/1/statuses/sample.json', options).open!
```

## Roadmap

### 0.2.0

  * UserStream, FilterStream and SampleStream

### 0.3.0

  * Reconnector object.


## Example

  * [Gazouillis sinatra](https://github.com/chatgris/gazouillis_sinatra)

## Copyright

MIT. See LICENSE for further details.
