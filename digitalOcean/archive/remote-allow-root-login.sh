# Remote allow root login
ssh -t $1@104.236.185.148 -A -F ssh-config "bash -s" < allow-root-login.sh