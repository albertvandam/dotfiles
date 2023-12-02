#!/bin/sh

echo "Configure NPM"

if [ -e $HOME/.npmrc ]; then
    /bin/mv $HOME/.npmrc $HOME/.npmrc.bak
fi

/bin/cp $HOME/.config/NPM/.npmrc $HOME/.npmrc

