# encoding: utf-8
module Gazouillis
  # This class concern is to handle stream connections.
  #
  class Stream
    include Celluloid::IO
    attr_reader :host, :path, :method

    def initialize(path, opts)
      @options = default_options.merge(opts)
      @path = path
      @host = opts.fetch(:host, "stream.twitter.com")
      @method = opts.fetch(:method, "GET")

      socket = TCPSocket.new "stream.twitter.com", 443
      ssl = OpenSSL::SSL::SSLSocket.new(socket.to_io, OpenSSL::SSL::SSLContext.new)
      ssl.sync = true
      ssl.connect

      @stream = ssl

      @http_parser = Http::Parser.new

      @http_parser.on_body = on_message_callback
      @http_parser.on_headers_complete = on_headers_complete
    end

    def open
      @stream.write request
      handle_connection
    end

    def close
      @stream.to_io.close
    end

    def on_message(message)
      # Hook method. To be override.
    end

    private

    def handle_connection
      @stream.each_line {|line| @http_parser << line } unless @stream.closed?
    end

    def on_message_callback
      Proc.new do |chunk|
        Actor.current.on_message chunk
      end
    end

    def on_headers_complete
      Proc.new do
        Actor.current.close if @http_parser.status_code != 200
      end
    end

    # TODO : a real request object, with nice headers.
    #
    def request
      request = "#{method} #{path} HTTP/1.1\r\n"
      request << "Host: #{@options[:host]}\r\n"
      request << "User-Agent: Gazouillis #{Gazouillis::VERSION}\r\n"
      request << "Authorization: #{oauth}\r\n"
      request << "\r\n"
      request
    end

    def oauth
      SimpleOAuth::Header.new method, full_url, {}, @options[:oauth]
    end

    def full_url
      "https://#{host}#{path}"
    end

    def default_options
      {
        host: 'stream.twitter.com',
        port: 443
      }
    end
  end
end
