
# How to install vagrant

Download and install VirtualBox.

Download and install Vagrant

# How to install RSpec

Install bundler:

1. sudo gem install bundler

2. Create a Gemfile for the project:
	
		touch Gemfile

3. Open in editor.

4. Add the following:

	source 'https://rubygems.org'

	gem 'rspec', '~> 3.0'

5. At the CL type:

bundle install --binstubs 

6. This will DL the resources.

7. At CL type:

	sudo ruby ./bin/rspec --init