echo "Configuring ZSH"

if [ ! -d ~/.local ]; then
    mkdir ~/.local
fi

if [ ! -d ~/.local/zsh-you-should-use ]; then
    git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.local/zsh-you-should-use
fi

sh $HOME/.config/zsh/scripts/configure.sh
