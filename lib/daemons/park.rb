#!/usr/bin/env ruby

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


require 'socket'               # Get sockets from stdlib

  # Replace this with your code

server = TCPServer.open(2000)  # Socket to listen on port 2000

loop {
  client = server.accept       # Wait for a client to connect
  data = client.recv(20)
  a = data.unpack('b*')
  b = a.split ""
       client.puts data
       client.close                 # Disconnect from the client
  
   #Rails.logger.auto_flushing = true
   #Rails.logger.info "This daemon is still running at #{Time.now}.\n"
 } 

