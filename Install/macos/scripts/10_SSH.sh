#!/bin/sh

sshDir="$HOME/.ssh";
keyFile="$sshDir/id_rsa"

if [ ! -f $keyFile ]; then
    echo "Create SSH key"

    ssh-keygen -t rsa -N '' -f $keyFile
fi
