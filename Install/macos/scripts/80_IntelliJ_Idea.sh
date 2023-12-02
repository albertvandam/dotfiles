#!/bin/sh

echo "Configure IntelliJ IDEA"

export PATH="$PATH:/Applications/IntelliJ IDEA.app/Contents/MacOS"

/bin/rm -f $HOME/idea.properties
ln -s $HOME/.config/IntelliJIdea/idea.properties $HOME/idea.properties

sh $HOME/.config/IntelliJIdea/plugins.ps1
