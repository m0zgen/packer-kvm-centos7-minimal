#!/bin/bash

# Envs
# ---------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

# Additions
# ---------------------------------------------------\
Info() {
	printf "\033[1;32m$@\033[0m\n"
}

Error()
{
	printf "\033[1;31m$@\033[0m\n"
}

isRoot() {
	if [ $(id -u) -ne 0 ]; then
		Error "You must be root user to continue"
		exit 1
	fi
	RID=$(id -u root 2>/dev/null)
	if [ $? -ne 0 ]; then
		Error "User root no found. You should create it to continue"
		exit 1
	fi
	if [ $RID -ne 0 ]; then
		Error "User root UID not equals 0. User root must have UID 0"
		exit 1
	fi
}

# isRoot

cd $SCRIPT_PATH

# Checks
# ---------------------------------------------------\
if [[ ! -f /usr/local/bin/packer ]]; then
	Error "Packer not installed to your system"
	Info "Please download packer and put file to /usr/local/bin/packer"
	Info "You can download packer from https://www.packer.io/downloads.html"
	exit 1
fi

if [[ -d $SCRIPT_PATH/centos7-minimal-img ]]; then
	rm -rf $SCRIPT_PATH/centos7-minimal-img
fi

packer build centos7-minimal.json