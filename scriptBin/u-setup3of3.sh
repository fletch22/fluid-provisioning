sudo aptitude    update
sudo aptitude -y upgrade
sudo aptitude install linux-image-extra-`uname -r`
sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\ > /etc/apt/sources.list.d/docker.list"
sudo aptitude    update
sudo aptitude install lxc-docker

# Continue script form https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-getting-started

sudo sed -i 's/DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw
sudo ufw reload

sudo apt-get update
sudo apt-get autoremove
sudo apt-get install apt-transport-https
sudo docker run -i -t ubuntu /bin/bashY


# More firewall setup
sudo sed -i 's/IPV6=no/IPV6=yes/g' /etc/default/ufw
