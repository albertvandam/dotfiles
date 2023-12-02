#!/bin/sh

if [[ "$OSTYPE" != darwin* ]]; then
    echo "Only supports MacOS"
    exit
fi

echo "Pulling updated configuration"
cd ~/.config
git pull

bash ~/.config/Install/update/update.sh
