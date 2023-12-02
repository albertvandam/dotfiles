#!/bin/sh

echo "Installing user apps"

if [ -d ~/.local/.fzf ]; then
    cd ~/.local/.fzf
    git pull
    cd /tmp
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/.fzf
fi
~/.local/.fzf/install --all --no-bash --no-fish --no-zsh
