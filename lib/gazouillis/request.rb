# encoding: utf-8
module Gazouillis
  class Request < String
    attr_reader :host, :path, :method, :oauth
    CRLF = "\r\n"

    def initialize(path, options)
      @host, @path, @method = options[:host], path, options[:method]
      @oauth = options[:oauth]
      super(request)
    end

    private

    def request
      [
        "#{method} #{path} HTTP/1.1",
        "Host: #{host}",
        "User-Agent: Gazouillis #{Gazouillis::VERSION}",
        "Authorization: #{oauth_header}",
        CRLF
      ].join(CRLF)
    end

    def oauth_header
      SimpleOAuth::Header.new method, full_url, {}, oauth
    end

    def full_url
      "https://#{host}#{path}"
    end

  end
end
