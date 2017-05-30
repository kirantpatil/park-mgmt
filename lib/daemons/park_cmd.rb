#!/usr/bin/env ruby
require 'socket'


# You might want to change this
#ENV["RAILS_ENV"] ||= "production"
ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
  $running = false
end

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
      begin
        @client = UDPSocket.new
	answer = 'Y'
        @client.connect(host, port)
      rescue
	answer = 'N'
      end while answer == 'N'
        @client.send(string, 0)
    end
  end
end

=begin 
=end
   while true
     @ccu = Ccunit.all
     @ccu.each do |ccu| 
       ip = ccu.ip
       port = ccu.port
         if ccu.zcunits.present?
           ccu.zcunits.each do |zcu|
             ary = ""
             ary << zcu.zcid.chr
             for i in 1..17
               ary << 0.chr
             end
             query_cmd = ary
             ParkCmd::Client.host = ip
             ParkCmd::Client.port = port
             ParkCmd::Client.set query_cmd
             sleep 1
           end
         else
           for i in 5..5
             ary = ""
             ary << i.chr
             for i in 1..17
               ary << 0.chr
             end
             query_cmd = ary
             ParkCmd::Client.host = ip
             ParkCmd::Client.port = port
             ParkCmd::Client.set query_cmd
             sleep 1 
           end
         end 
     end
   end

=begin Threshold setting cmd
       ary << zcu.zcid.chr
       ary << 0.chr
       ary << cmd_thrval.chr
       for i in 1..15
         ary << 0.chr
       end
=end

=begin Specific Threshold setting cmd
       ary << zcu.zcid.chr
       ary << lot.lotid.chr
       ary << cmd_thrval.chr
       for i in 1..15
         ary << 0.chr
       end
=end

=begin
  for i in 1..1
       ary = ""
       #ary << zcu.zcid.chr
       ary << 4.chr
       ary << 255.chr
       for i in 1..17
         ary << 0.chr
       end
       ParkCmd::Client.host = '192.168.16.254'
       ParkCmd::Client.port = 3073
       ParkCmd::Client.set ary
  end
=end
