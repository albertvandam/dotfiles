#!/bin/sh

echo "Installing Maven"

curl https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip --output /tmp/maven.zip

if [ ! -d $HOME/.local ]; then
    mkdir -p $HOME/.local
fi

unzip -o /tmp/maven.zip -d $HOME/.local/maven

/bin/rm /tmp/maven.zip

if [ ! -d $HOME/.m2 ]; then
    mkdir $HOME/.m2
fi
if [ -f $HOME/.m2/settings.xml ]; then
    /bin/mv $HOME/.m2/settings.xml $HOME/.m2/settings.xml.bak
fi

cp $HOME/.config/Install/Maven/settings.xml $HOME/.m2/settings.xml
