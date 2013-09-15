# encoding: utf-8
module Gazouillis
  # This class concern is to handle connections to_user_stream.
  #
  class UserStream < Stream
    API_VERSION = "1.1"

    def initialize(opts)
      opts.merge!({
        host: "userstream.twitter.com"
      })
      super "/#{API_VERSION}/user.json", opts
    end
  end
end
