adduser --gecos GECOS --disabled-password $1
echo "$1:iwaglmlah" | chpasswd
gpasswd -a $1 sudo
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
service ssh restart
