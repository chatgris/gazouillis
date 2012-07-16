# encoding: utf-8
module Gazouillis
  class Stream
    include Celluloid::IO
    HOST = "stream.twitter.com"

    attr_reader :http_parser, :headers, :status_code

    def initialize(path, auth)
      @path = path
      @auth = auth

      socket = TCPSocket.new "stream.twitter.com", 443
      ssl = OpenSSL::SSL::SSLSocket.new(socket.to_io, OpenSSL::SSL::SSLContext.new)
      ssl.sync = true
      ssl.connect

      @stream = ssl

      @http_parser = Http::Parser.new
      @http_parser.on_headers_complete = proc{ :stop }
    end

    def listen
      @stream.write request

      @stream.each_line do |line|
        # end of the headers
        if line == "\r\n"
          @headers     = http_parser.headers
          @status_code = http_parser.status_code
          # TODO : if status_code's not 200 : break and delegates to a handler.
        elsif status_code == 200 && !line.match(/\w\r\n/)
          # TODO : delegates response to a handler. Job's done.
          $stderr.puts MultiJson.load(line)
        else
          http_parser << line
        end
      end
    end

    private

    # TODO : a real request object, with nice headers.
    #
    def request
      request = "GET #{@path} HTTP/1.1\r\n"
      request << "Host: #{HOST}\r\n"
      request << "Authorization: Basic #{basic_auth}\r\n"
      request << "\r\n"
      request
    end

    def basic_auth
      ["#{@auth[:user]}:#{@auth[:passord]}"].pack('m').strip
    end
  end
end
