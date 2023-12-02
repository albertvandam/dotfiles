#!/bin/sh

echo "Configure VS Code"

if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
    /bin/mv -f $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.json.old
fi

ln -s $HOME/.config/Install/VsCode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

sh $HOME/.config/Install/VsCode/plugins.ps1
