#!/bin/sh

# Ask for the administrator password upfront
echo ""
echo ""
echo "Please enter your MacOs password when prompted"
echo ""
echo ""

tput bel
sudo -v
if [ $? -ne 0 ]; then
    echo "You do not have SUDO rights"
    exit
fi

# Keep-alive: update existing `sudo` time stamp until configuration is done
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

brewCmd=`which brew`

if [ "$brewCmd" == "" ]; then
    echo "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ "$HOMEBREW_PREFIX" == "" ];
    then
        CPU=`sysctl -n machdep.cpu.brand_string`
        if [[ "$CPU" == *Intel* ]]; then
            export HOMEBREW_PREFIX="/usr/local"
        else
            export HOMEBREW_PREFIX="/opt/homebrew"
        fi
    fi

    if [ ! -e ~/.local/zsh_config ]; then
        mkdir -p ~/.local/zsh_config
    fi
    if [ -e ~/.local/zsh_config/brew.env ]; then
        rm ~/.local/zsh_config/brew.env
    fi

    $HOMEBREW_PREFIX/bin/brew shellenv >~/.local/zsh_config/brew.env

    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
    brew analytics off

else
    echo "Updating Homebrew"
    brew update
    brew upgrade
fi

for file in $(find ~/.config/Install/macos/scripts -type f -name "*.sh" | sort ); 
do
    sh $file
done

for file in $(find ~/.config/Install/nix/scripts -type f -name "*.sh" | sort ); 
do
    sh $file
done

PUBKEY=`/bin/cat $HOME/.ssh/id_rsa.pub`
sed "s#{PUBKEY}#$PUBKEY#g" ~/.config/Install/macos/info_template.html >$HOME/Desktop/Environment_Info.html

tput bel
echo
echo
echo "Installation done"
echo
echo "Going to reboot in 30 seconds"
sleep 30

sudo shutdown -r now
