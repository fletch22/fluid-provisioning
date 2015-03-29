#!/usr/bin/ruby

# Add command line arg to wipe the existing Vagrant file.
# Detect default port chosen during 'Vagrant up'; return port from 'startBox'
# Use port to start ssh work to configure box.

require 'open3'
require 'trollop'
require 'fileutils'

puts "\n\nRegenting Vagrant ...\n\n"

class VagrantRegent
	
	def initVagrant(isForceClean)
		puts "\nInitiating Vagrant ..."

		cleanup(isForceClean)

		Open3.popen3('vagrant init hashicorp/precise32') {|stdin, stdout, stderr, wait_thr|

			stdin.close			
			stdout.each {|line| 
				puts line 
			}

			stdout.close

			begin
				handleStatusAndErr(wait_thr.value, stderr, 'There was an error initiating Vagrant.')		
			ensure
				stderr.close
			end
		}
	end

	def cleanup(isForceClean)
		puts 'IS force_clean: ' + isForceClean.to_s
		if (isForceClean) then
			vagrantFilename = 'Vagrantfile'
			if (File.exist?(vagrantFilename)) then
				puts 'Vagrant file exists and will be deleted.'
				FileUtils.rm vagrantFilename, :verbose => true
				puts 'Vagrant file removed.'
			end
			vagrantFolder = '.vagrant'
			if (File.exist?(vagrantFolder)) then 
				puts 'Vagrant folder exists and will be deleted'
				FileUtils.rmdir vagrantFolder, :verbose => true
				puts 'Vagrant folder removed.'
			end
		end
	end

	def startBox
		port = -1
		puts "\nAbout to call 'vagrant up'...\n\n"
		Open3.popen3('vagrant up') {|stdin, stdout, stderr, wait_thr|

			stdin.close			
			stdout.each {|line|
				token = 'default: SSH address:'
				index = line.index(token)
				if (nil != index) then
					port = extractPortFromReportLine(line, token, index)
				end
				puts line 
			}

			stdout.close

			begin
				handleStatusAndErr(wait_thr.value, stderr, 'There was an error calling Vagrant ''up''.')		
			ensure
				stderr.close
			end
		}
		return port
	end

	def extractPortFromReportLine(line, token, index) 
		index += token.length
		ipAndPort = line[index..-1].strip
		token = ":"
		index = ipAndPort.index(token) + 1
		return ipAndPort[index..-1]
	end

	def handleStatusAndErr(status, err, userFailureMessage)
		if status.success?
			puts "Success: " + status.to_s
		else 
			handleErr(err, userFailureMessage)
		end
	end
	
	def handleErr(err, userFailureMessage)
		if (nil != err) then
			errorMessage = ""
			err.each {|line| 
				errorMessage = errorMessage + line 
			}
			puts "\nFailed! Error: " + errorMessage + "\n\n"
		else 
			puts "There was an indeterminate error."
		end
		raise userFailureMessage
	end
end

opts = Trollop::options do
  opt :force_clean, "Cleans out the .vagrant folder and deletes Vagrant file.", :default => false
end

begin
	# if (nil != ARGV[0]) then
	# 	firstArgument = ARGV[0]
	# 	if (0 != firstArgument.index("--")) then
	# 		raise "Arguments must start with '--'."
	# 	end
	# end

	p opts.force_clean

	vagrantRegent = VagrantRegent.new()
	vagrantRegent.initVagrant(opts.force_clean)
	# port = vagrantRegent.startBox()
	# puts "\n\nNew port number: " + port
rescue Exception => message  
	puts 'Program aborting due to: ' + message.to_s
end