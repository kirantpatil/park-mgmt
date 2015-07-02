#require 'socket.so'
require 'socket'

class UDPServer
  def initialize(port)
    @port = port
  end

  def start
    @socket = UDPSocket.new
    @socket.bind("", @port) # is nil OK here?
    while true
      # packet = @socket.recvfrom(1024)
      # puts packet
      handle(@socket)
    end
  end

  def handle(s)
    data, ccaddr = s.recvfrom(20)
    puts data
    puts ccaddr[1],ccaddr[2]
  end
end

server = UDPServer.new(2000)
server.start
