#!/bin/sh

if [[ "$OSTYPE" != darwin* ]]; then
    echo "Only supports MacOS"
    exit
fi

echo "Checking if Git is installed"
git -v
if [ $? -ne 0 ]; then
    tput bel
    echo "Please first install xCode command line tools."
    echo "The installer should open automatically, otherwise run 'xcode-select —-install' in a terminal." 
    xcode-select —-install
    exit
fi

read_char() {
    stty -icanon -echo
    eval "$1=\$(dd bs=1 count=1 2>/dev/null)"
    stty icanon echo
}

if [ -d ~/.config ]; then
    tput bel
    echo "$HOME/.config already exists"
    echo "Continue [y/N]"

    while : ; do
        read_char char

        if [ "$char" = "y"  ] || [ "$char" = "Y"  ]; then
            echo "Deleting $HOME/.config"
            /bin/rm -rf ~/.config

            break
        fi
        if [ "$char" = "n"  ] || [ "$char" = "N"  ]; then
            exit
        fi
    done
fi

echo "Cloning dotfiles repo"
git clone https://github.com/albertvandam/dotfiles.git ~/.config
cd ~/.config
git submodule init
git submodule update
cd ~/.config/Vim/.vim/pack/themes/start/dracula
git checkout master
git pull

sh ~/.config/Install/macos/configure.sh
