#!/bin/sh

if [[ "$OSTYPE" != darwin* ]]; then
    echo "Only supports MacOS"
    exit
fi

echo "Pulling updated configuration"
cd ~/.config
git pull

cd ~/.local/powerlevel10k
git pull

cd ~/.local/zsh-auto-notify
git pull

bash ~/.config/Install/update/update.sh
