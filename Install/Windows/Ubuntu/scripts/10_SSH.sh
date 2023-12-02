#!/bin/sh

if [ -d ~/.ssh ]; then
    rm -rf ~/.ssh
fi

mkdir ~/.ssh
cp $WINHOME/.ssh/* ~/.ssh
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/*
