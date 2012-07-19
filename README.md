# gazouillis

Gazouillis aims to be a fast and reliable twitter stream client.

## Status

Very early stage. Not ready for production.

## Usage

``` ruby
require 'gazouillis'

options = {
  auth: {
    user: 'user',
    password: 'password'
  }
}
Gazouillis::Stream.new('/1/statuses/sample.json', options).open!
```

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself in another branch so I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


## Copyright

MIT. See LICENSE for further details.
