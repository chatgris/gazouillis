# encoding: utf-8
module Gazouillis
  # This class concern is to handle stream connections.
  #
  class Stream
    include Celluloid::IO
    attr_reader :request, :stream, :http_parser

    def initialize(path, opts)
      options = default_options.merge(opts)
      @request = Request.new(path, options)
      @stream = set_stream(TCPSocket.new options[:host], options[:port])
      @http_parser = Http::Parser.new
      http_parser.on_body = method(:on_message)
      http_parser.on_headers_complete = method(:on_headers_complete)
    end

    def open
      stream.write request
      handle_connection
    end

    def close
      stream.to_io.close
    end

    def on_message(message)
      # Hook method. To be override.
    end

    private

    def set_stream(socket)
      OpenSSL::SSL::SSLSocket.new(socket.to_io,
                                  OpenSSL::SSL::SSLContext.new).tap {|ssl|
        ssl.sync = true
        ssl.connect
      }
    end

    def handle_connection
      stream.each_line {|line| http_parser << line } unless stream.closed?
    end

    def on_headers_complete(headers)
      Actor.current.close if http_parser.status_code != 200
    end

    def default_options
      {
        host: 'stream.twitter.com',
        port: 443,
        method: "GET"
      }
    end
  end
end
