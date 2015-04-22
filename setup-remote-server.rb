#!/usr/bin/ruby
require 'net/ssh'

class RemoteServerSetup

	def sendFile()
		puts "Attemptiung remote server setup"
	  	# //Net::SCP.start("127.0.0.1", "vagrant", {:password => "vagrant", :port => 2222}) do |scp|
	    # synchronous (blocking) upload; call blocks until upload completes
	    # //scp.upload! "./scriptBin/u-setup1of3.sh", "/"

	    Net::SSH.start("127.0.0.1", "vagrant", {:password => "vagrant",:port => 2222, :verbose => Logger::INFO}) do |ssh|
  			ssh.scp.upload! "./scriptBin/u-setup1of3.sh", "/home/vagrant/u-setup1of3.sh"
		end

	    # asynchronous upload; call returns immediately and requires SSH
	    # event loop to run
	    # channel = scp.upload("/local/path", "/remote/path")
	    # channel.wait
	end

 end

