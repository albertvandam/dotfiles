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

echo "Updating Homebrew"
brew update --force
brew upgrade
brew link --overwrite node@22
npm install -g npm@latest

sh $HOME/.config/IntelliJIdea/plugins.ps1
sh $HOME/.config/Install/VsCode/plugins.ps1

if [ -d ~/.local/update_extra ]; then
    for file in $(find ~/.local/update_extra -name "*.sh" | sort ); 
    do
        sh $file
    done
fi
