echo "Configuring ZSH"

sh $HOME/.config/zsh/scripts/configure.sh

if [ "$HOMEBREW_PREFIX" == "" ];
then
    CPU=`sysctl -n machdep.cpu.brand_string`
    if [[ "$CPU" == *Intel* ]]; then
        export HOMEBREW_PREFIX="/usr/local"
    else
        export HOMEBREW_PREFIX="/opt/homebrew"
    fi
fi

if [ -f $HOMEBREW_PREFIX/bin/zsh ]; then
    CURRENT=`whoami`
    sudo chsh -s $HOMEBREW_PREFIX/bin/zsh $CURRENT
fi
