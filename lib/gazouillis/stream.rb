# encoding: utf-8
module Gazouillis
  class Stream
    include Celluloid::IO
    HOST = "stream.twitter.com"

    def initialize(path, auth)
      @path = path
      @auth = auth

      socket = TCPSocket.new "stream.twitter.com", 443
      ssl = OpenSSL::SSL::SSLSocket.new(socket.to_io, OpenSSL::SSL::SSLContext.new)
      ssl.sync = true
      ssl.connect

      @stream = ssl
    end

    def listen
      @stream.write request

      @stream.each_line do |line|
        $stderr.puts line
      end
    end

    private

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
