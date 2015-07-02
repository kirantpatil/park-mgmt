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
      puts "I am here"
      data, cciport = socket.recvfrom(20)
      ccport = cciport[1]
      ccaddr = cciport[2]
      zcaddrasc = data.slice!(0)
      zcaddr = zcaddrasc.unpack("H*").first.to_i(16)
      slsaddrup = data.unpack("B*")
      slsaddr = slsaddrup[0]
      
      if Event.where(zcaddr: zcaddr, ccport: ccport).present?
        e = Event.find_by(zcaddr: zcaddr, ccport: ccport)
        e.pdata = slsaddr
        e.save
      else
        e = Event.new(pdata: slsaddr, ccaddr: ccaddr, ccport: ccport, zcaddr: zcaddr)
        e.save
      end
    end
  end
end
 
  server = ParkServ::UDPServer.new(2000)
  server.start
