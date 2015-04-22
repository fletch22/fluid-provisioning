#!/usr/bin/ruby

require 'net/scp'

class RemoteServerSetup

	def sendFile()
	  Net::SCP.start("127.0.0.1:2222", "vagrant", :password => "vagrant") do |scp|
	    # synchronous (blocking) upload; call blocks until upload completes
	    scp.upload! "scriptBin/u-setup1of3.sh", "/"

	    # asynchronous upload; call returns immediately and requires SSH
	    # event loop to run
	    # channel = scp.upload("/local/path", "/remote/path")
	    # channel.wait
	  end
	end

 end