require 'socket'

module ParkCmd
  class Client
    class << self
      attr_accessor :host, :port
    end

    def self.set(key)
      request key
    end

    def self.request(string)
      # Create a new connection for each operation.
      @client = UDPSocket.new
      @client.connect(host, port)
      @client.send(string, 0)
    end
  end
end
