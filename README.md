# gazouillis

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
  auth: {
    user: 'user',
    password: 'password'
  }
}
Tweets.new('/1/statuses/sample.json', options).open!
```

## Roadmap

### 0.1.0

  * Reconnector object.

### 1.0.0

  * Oauth.

## Copyright

MIT. See LICENSE for further details.
