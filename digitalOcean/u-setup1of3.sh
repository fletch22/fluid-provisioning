mkdir -p ~/.ssh
chmod 0700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 0644 ~/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCAjspN0hYfLBt+gyq87OzbBLhFOs0IXLu1+ZKvfJgXIlwx+GsPhrFD4Zqgr2T9iZF+IW0eW2P3t5IKGZW3tXUH3Np63tdWXM6QK6x+IHDrb3WFDnBT/AkpJ+Zz2Rkwtao71f+K3YrSd7XHx/tH0HExeRbFynvSD32yZ2jQUkiP5tIWNyR2UvSUjUlyB+jExbVfnZ4vmMdGpS3FQcYcn00qCtqzvUdA4I3BgofgEx4HoA3YnkskgbVSAKT5QDSSaOciAFUbbpmyK11RixUDnkIQN7SPEcEWbOMip81zJbFAskrLcmDdSvf0wQ1bhCwoePbXmT/t9tt3SO4Xt/3eCiJ chris@fletch22.com' >> ~/.ssh/authorized_keys

# Adds the user passed on the command line and adds user to suod-ers group.
adduser --gecos GECOS $1
gpasswd -a $1 sudo

# Exits from SSH
kill -9 "$(ps --pid $$ -oppid=)"


