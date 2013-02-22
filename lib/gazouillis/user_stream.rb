# encoding: utf-8
module Gazouillis
  # This class concern is to handle stream connections.
  #
  class UserStream < Stream
    def initialize(opts)
      opts.merge!({
        host: "userstream.twitter.com"
      })
      super "/1.1/user.json", opts
    end
  end
end
