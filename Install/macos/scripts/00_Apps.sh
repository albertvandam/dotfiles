#!/bin/sh

echo "Installing Apps"

# --cleanup removes everything installed by brew that is not in the file
brew bundle --file=~/.config/Install/macos/Brewfile --no-lock

sudo chmod go-w "$HOMEBREW_PREFIX/share" 
sudo chmod -R go-w "$HOMEBREW_PREFIX/share/zsh"

mkdir -p ~/.docker/cli-plugins
ln -sfn /opt/homebrew/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose

mkdir -p ~/.docker/cli-plugins
  ln -sfn /opt/homebrew/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
