#!/bin/sh

export WINHOME=$1

if [ -d ~/.config ]; then
    rm -rf ~/.config
fi
if [ -L ~/.config ]; then
    rm -rf ~/.config
fi
ln -s $WINHOME/.config $HOME/.config

for file in $(find $HOME/.config/Install/Windows/Ubuntu/scripts -type f -name "*.sh" | sort ); 
do
    sh $file
done

for file in $(find $HOME/.config/Install/nix/scripts -type f -name "*.sh" | sort ); 
do
    sh $file
done
