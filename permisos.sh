#!/usr/bin/env bash

remoteuser=$1
remoteip=$2

#http://ubuntuforums.org/showthread.php?t=2247887

echo "* ssh-keygen -t rsa"
if ssh-keygen -t rsa | grep -q COMMAND_FAILED ; then 
    echo " - Failed to create ssh-keygen -t rsa"
    exit 1
fi

echo "* ssh root@remoreip mkdir -p .ssh" 
if ssh $remoteuser@$remoteip mkdir -p .ssh | grep -q COMMAND_FAILED ; then 
	echo " - Failed to create remote folder: .ssh"
	exit 1
fi

echo "* cat .ssh/id_rsa.pub | ssh root@$remoteip 'cat >> .ssh/authorized_keys'"
if cat .ssh/id_rsa.pub | ssh $remoteuser@$remoteip 'cat >> .ssh/authorized_keys' | grep -q 

COMMAND_FAILED ; then 
echo " - Failed to move local id_rsa to remote folder: .ssh"
	exit 1
fi

echo "* Fixed permisions"
if chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys; | grep -q COMMAND_FAILED ; then 
	
	echo " - Failed to assign permisions"
fi

echo "* ssh-add"
if ssh-add | grep -q COMMAND_FAILED ; then 
	echo " - Failed to add ssh permision"
	exit 1
fi

echo "* Done"
