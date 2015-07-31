require 'socket'

module ParkCmd
  class Client
    class << self
      attr_accessor :host, :port
    end

    def self.get(key)
      request "GET #{key}"
    end

    def self.set(key)
      request key
    end

    def self.request(string)
      # Create a new connection for each operation.
      @client = UDPSocket.new
      @client.connect(host, port)
      # while true
        @client.send(string, 0)
        # sleep 2
      # end 
    end
  end
end

#ParkCmd::Client.host = '192.168.16.254'
#ParkCmd::Client.port = 3073

#puts ParkCmd::Client.set '2111'
#puts ParkCmd::Client.get 'prez'
#puts ParkCmd::Client.get 'vp'
