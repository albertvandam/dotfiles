#!/bin/sh

if [ -f ~/.bash_history ]; then
    rm ~/.bash_history
fi
if [ -f ~/.bash_logout ]; then
    rm ~/.bash_logout
fi
if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
fi
if [ -f ~/.profile ]; then
    rm ~/.profile
fi
