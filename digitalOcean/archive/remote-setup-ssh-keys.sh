# Basically this tells bash to call one program with argument.
# So bash is called. Then do-ssh-remote-sh is invoked with the argument setup-ssh-keys.sh
# do-ssh-remote.sh will use that argument to execute a local script on the remote server.
ssh $1@104.236.185.148 -q -F ssh-config "bash -s " < setup-ssh-keys.sh