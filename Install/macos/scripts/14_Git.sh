#!/bin/sh

echo "Configure Git"

gu=`git config --global --get user.name`
ge=`git config --global --get user.email`

if [ -e $HOME/.gitconfig ]; then
    mv $HOME/.gitconfig $HOME/.gitconfig.bak
fi

if [[ $gu != "" ]]; then
    git config --global user.name "$gu"
fi
if [[ $ge != "" ]]; then
    git config --global user.email "$ge"
fi

git config --global include.path "$HOME/.config/Git/.gitconfig"
