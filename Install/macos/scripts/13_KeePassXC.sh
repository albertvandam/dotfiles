#!/bin/sh

echo "Configuring KeyPassXC"

if [ ! -d $HOME/Library/Application\ Support/KeePassXC ]; then
    mkdir -p $HOME/Library/Application\ Support/KeePassXC
fi
if [ -e $HOME/Library/Application\ Support/KeePassXC/keepassxc.ini ]; then
    rm $HOME/Library/Application\ Support/KeePassXC/keepassxc.ini
fi

cp $HOME/.config/Install/KeePassXC/keepassxc.ini $HOME/Library/Application\ Support/KeePassXC
