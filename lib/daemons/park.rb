#!/usr/bin/env ruby
require 'socket'               # Get sockets from stdlib

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

root = File.expand_path(File.dirname(__FILE__))
root = File.dirname(root) until File.exists?(File.join(root, 'config'))
Dir.chdir(root)

require File.join(root, "config", "environment")

$running = true
Signal.trap("TERM") do 
  $running = false
end


  # Replace this with your code
  port = 2000

Socket.udp_server_loop(port) { |msg, msg_src|
  text = msg
  msg_src.reply "aaa"
  # puts msg_src.port # not able to access port

  puts msg_src
  
  e = Event.find(1)
  zcaddr = text.slice!(0)
  sladdr = text.unpack("B*")
  puts sladdr
  e.pdata = sladdr[0]
  e.save
}
