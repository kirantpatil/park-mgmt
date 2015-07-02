#require 'socket'

module ParkServ
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

    def handle(socket)
          puts "I am here"
      #data, cciport = socket.recvfrom(20)
      #ccport = cciport[1]
      #ccaddr = cciport[2]
      #zcaddrasc = data.slice!(0)
      #zcaddr = zcaddrasc.unpack("H*").first.to_i(16)
      #slsaddrup = data.unpack("B*")
      #slsaddr = slsaddrup[0]

      #  if Event.where(zcaddr: zcaddr, ccport: ccport).present?
      #    puts "I am here"
      #    e = Event.find_by(zcaddr: zcaddr, ccport: ccport)
      #    e.pdata = slsaddr
      #    e.save
      #  else
      #    e = Event.new(pdata: slsaddr, ccaddr: ccaddr, ccport: ccport, zcaddr: zcaddr)
      #    e.save
      #  end
    end
  end
end
