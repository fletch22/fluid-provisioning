# Basically this is the Digital Ocean connection to execute a local script remotely.
# $1 is linux standard way of referring to the first passed argument on a command line invocation of this script.
# Like this: bash <someScriptFileName>.sh foo<Enter>
# This would cause "foo" to be passed to this file and replace $1.
# Warning: Attempting to put the IP in the ssh-config file will result in TTY warnings/errors. The script will execute
# but the messages will be confusing.
ssh 104.236.185.148 -q -F ssh-config "bash -s" < $1 $2