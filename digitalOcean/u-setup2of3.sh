# This script is assumes we have logged in using the new login. For example: fletch22

# Use public key for this login.
mkdir -p ~/.ssh
chmod 0700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 0644 ~/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCAjspN0hYfLBt+gyq87OzbBLhFOs0IXLu1+ZKvfJgXIlwx+GsPhrFD4Zqgr2T9iZF+IW0eW2P3t5IKGZW3tXUH3Np63tdWXM6QK6x+IHDrb3WFDnBT/AkpJ+Zz2Rkwtao71f+K3YrSd7XHx/tH0HExeRbFynvSD32yZ2jQUkiP5tIWNyR2UvSUjUlyB+jExbVfnZ4vmMdGpS3FQcYcn00qCtqzvUdA4I3BgofgEx4HoA3YnkskgbVSAKT5QDSSaOciAFUbbpmyK11RixUDnkIQN7SPEcEWbOMip81zJbFAskrLcmDdSvf0wQ1bhCwoePbXmT/t9tt3SO4Xt/3eCiJ chris@fletch22.com' >> ~/.ssh/authorized_keys

# Remove root ability to log on. For security.
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo service ssh restart

# Setup Firewall. Allow ssh and turn it on!
sudo ufw allow ssh
sudo ufw enable

#Setup Timezone stuff.
sudo dpkg-reconfigure tzdata

# Setup up apt-get
sudo apt-get update

#Set up Time server
sudo apt-get install ntp

# Install swap file
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'

# Reboot to make swap drive active
sudo reboot --verbose

