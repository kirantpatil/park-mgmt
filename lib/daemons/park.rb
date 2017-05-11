#!/usr/bin/env ruby
require 'socket'               # Get sockets from stdlib

# You might want to change this
# ENV["RAILS_ENV"] ||= "production"
 ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
  $running = false
end


  # Replace this with your code
  
module ParkServ
  class UDPServer
    def initialize(port)
      @port = port
    end

    def start
      @socket = UDPSocket.new
      @socket.bind("", @port) # is nil OK here?
      while true
        handle(@socket)
      end
    end
      
    def handle(socket)
      data, cciport = socket.recvfrom(20)
      ccport = cciport[1]
      ccaddr = cciport[2]
      zcaddrasc = data.slice!(0)
      zcaddr = zcaddrasc.unpack("H*").first.to_i(16)
      #slsaddrup = data.unpack("B*")
      slsaddrup = data.unpack("b*")
      slsaddr = slsaddrup[0]
      a = slsaddr.split('')
      puts ccaddr
      puts ccport
      puts zcaddr
      # puts a

      c = Ccunit.find_by_ip(ccaddr)
=begin
=end
      if c.present? && c.zcunits.find_by_zcid(zcaddr).present?
        count = 0
        @zcu = c.zcunits
        @zcu.each do |zcu|
          if zcu.zcid != zcaddr
            count += zcu.lots.count
          else
            break
          end
        end
        j = count + 1
        for i in 0..63   #a.size-1 
          l = c.zcunits.find_by_zcid(zcaddr).lots.find_by_lotid(j)
          if l.status == "r"
          elsif  a[i] == "0" 
            l.status = "v"
          else 
            l.status = "o"
          end
          l.save
          j += 1
        end
      elsif c.present? && zcaddr != 0
        z = Zcunit.new(zcid: zcaddr, ccunit_id: c.id)
        z.save
        count = 0
        @zcu = c.zcunits
        @zcu.each do |zcu|
          count += zcu.lots.count
        end
        j = count + 1
        for i in 0..63  #a.size-1 
          l = Lot.new
          l.lotid = j
          if a[i] == "0"
            l.status = "v"
          else
            l.status = "o"
          end
          l.zcunit_id = z.id
          l.save
          j += 1
        end
      else
      end
    end
  end
end
 
  server = ParkServ::UDPServer.new(2000)
  server.start
