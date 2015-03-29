# These script commands will be placed in Google Drive initially. Then they will be
# put under source control (GIT — probably BitBucket).
# Please note these files could be refactored to take even less time to execute.
 
# Execute the following. You will need to reset the admin password. The initial root password will be emailed to you.
ssh root@104.236.252.246 -F ssh-config

# Execute this to send the setup files to the server.
bash send-files-to-digital-ocean.sh

# Login as root to start executing the scripts.
ssh root@104.236.252.246

# Execute script 1 of 3
bash /usr/bin/u-setup1of3.sh fletch22

# Execute the following to login. 
ssh fletch22@104.236.252.246

# Exucute the following to run 2 of 3.
bash /usr/bin/u-setup2of3.sh

# Logon to run script 3 of 3
ssh fletch22@1104.236.252.246

# Exucute the following to run 3 of 3.
bash /usr/bin/u-setup3of3.sh

# Docker Notes
To exit a running container type Ctrl+p,q

# To run docker and map a port to the outside world.
# Basicall this runs the my_mongodb container and inside the container it exposes port 28017. This is MongoDB's default admin port.
# Then 27107 is the host's port from which I will route traffice to 28017. This routing will work only if I expose the host's external
# port with the the firewall tool (ufw, in this case.)
# /bin/bash is supposed to start a bash shell but for some reason it doesn't work in this case.
sudo docker run  -p 27107:28017 -i -t my_mongodb /bin/bash

# To rename an image, use the docker tag functionality

# To open a firewall port 21707
sudo ufw allow 21707/tcp

# To close a firewall port 21707
sudo uwf deny 21707/tcp


