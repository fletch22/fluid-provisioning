#!/usr/bin/ruby

# First ruby program
require 'net/ssh'
require 'net/scp'


class HelloWorld
   def initialize(name)
      @name = name.capitalize
   end
   def sayHi
      puts "Hello #{@name}!"
   end
end

hello = HelloWorld.new("World")
hello.sayHi

Net::SSH.start('104.236.252.246', 'fletch22', :password => "iwaglmlah") do |ssh|
	# capture all stderr and stdout output from a remote process
 	output = ssh.exec!("hostname")

 	# capture only stdout matching a particular pattern
  	stdout = ""
  	ssh.exec!("ls -l") do |channel, stream, data|
	    stdout << data if stream == :stdout
  	end
  	puts stdout

	# Open a new channel and configure a minimal set of callbacks, then run
	# the event loop until the channel finishes (closes)
	channel = ssh.open_channel do |ch|
		ch.exec "ps -ef" do |ch, success|
		  raise "Could not execute command." unless success

		  # "on_data" is called when the process writes something to stdout
		  ch.on_data do |c, data|
		    $stdout.print data
		  end

		  # "on_extended_data" is called when the process writes something to stderr
		  ch.on_extended_data do |c, type, data|
		    $stderr.print data
		  end

		  ch.on_close { puts "done!" }
		end
	end

	#   channel.wait

	#   Forward connections on local port 1234 to port 80 of www.capify.org
	#  	ssh.forward.local(1234, "www.capify.org", 80)
	#  	ssh.loop { true }
end
#puts open("scp://fletch@104.236.252.246/test.txt").read
