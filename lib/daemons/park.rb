#!/usr/bin/env ruby
require 'socket'               # Get sockets from stdlib
#require 'parkmgmt/udpserver'

#require "#{Rails.root}/app/helpers/application_helper"
#include ApplicationHelper

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
      slsaddrup = data.unpack("B*")
      slsaddr = slsaddrup[0]
      a = slsaddr.split('')

      c = Ccunit.find_by_ip(ccaddr)
=begin
=end
      if c.zcunits.find_by_zcid(zcaddr).present?
        j = 1
        for i in 0..a.size-1 
          l = c.zcunits.find_by_zcid(zcaddr).lots.find_by_lotid(j)
          if ( a[i] == "0" )
            l.status = "vacant"
          else
            l.status = "Occupied"
          end
          l.save
          j += 1
        end
      else
        z = Zcunit.new(zcid: zcaddr, ccunit_id: c.id)
        z.save
        j = 1
        for i in 0..a.size-1 
          l = Lot.new
          l.lotid = j
          if ( a[i] == "0" )
            l.status = "vacant"
          else
            l.status = "Occupied"
          end
          l.zcunit_id = z.id
          l.save
          j += 1
        end
      end
    end
  end
end
 
  server = ParkServ::UDPServer.new(2000)
  server.start
