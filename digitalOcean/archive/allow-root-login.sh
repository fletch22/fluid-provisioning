# Allow root login
sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config