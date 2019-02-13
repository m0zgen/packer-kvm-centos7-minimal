#!/bin/bash

echo "Hello from packer!" > /root/hello.txt

yum install epel-release nano git wget acpid net-tools -y
yum install htop -y