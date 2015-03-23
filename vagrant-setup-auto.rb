#!/usr/bin/ruby

require 'open3'

puts "\n\nRegenting Vagrant ...\n\n"

class VagrantRegent
	
	def initVagrant
		puts "\nInitiating Vagrant ..."
		Open3.popen3('vagrant init hashicorp/precise32') {|stdin, stdout, stderr, wait_thr|

			stdin.close			
			stdout.each {|line| 
				puts line 
			}

			stdout.close

			begin
				handleStatusAndErr(wait_thr.value, stderr, 'There was an error initiating Vagrant.')		
			ensure
				puts "Closing stderr"
				stderr.close
			end
		}
	end 

	def startBox
		puts "\nAbout to call 'vagrant up'...\n\n"
		Open3.popen3('vagrant up') {|stdin, stdout, stderr, wait_thr|

			stdin.close			
			stdout.each {|line| 
				puts line 
			}

			stdout.close

			begin
				handleStatusAndErr(wait_thr.value, stderr, 'There was an error calling Vagrant ''up''.')		
			ensure
				puts "Closing stderr"
				stderr.close
			end
		}
	end

	def handleStatusAndErr(status, err, userFailureMessage)
		if status.success?
			puts "Success: " + status.to_s
		else 
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

	def ls() 
		Open3.popen3('dir') {|stdin, stdout, stderr, wait_thr|
			
			stdout.each { |line| puts line }
			stdin.close
			stdout.close
			stderr.close

			puts wait_thr.value.success?		
		}
	end
end 

begin
	vagrantRegent = VagrantRegent.new()
	vagrantRegent.initVagrant()
	vagrantRegent.startBox()
	# vagrantRegent.ls()
rescue Exception => message  
	puts 'Program aborting due to: ' + message.to_s
end