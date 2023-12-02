#!/bin/sh

if [ ! -d ~/.local ]; then
    mkdir ~/.local
fi

if [ ! -e ~/.local/zsh_config ]; then
    mkdir ~/.local/zsh_config
fi
if [ ! -f ~/.local/zsh_config/auto-notify.env ]; then
 echo "AUTO_NOTIFY_IGNORE+=("vi")" >~/.local/zsh_config/auto-notify.env
fi

if [ ! -d ~/.history ]; then
  mkdir ~/.history
fi

if [ -e ~/.zsh_history ]; then
    mv ~/.zsh_history ~/.history/zsh
fi

if [ ! -d ~/.local/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/powerlevel10k
fi    

if [ ! -d ~/.local/zsh-auto-notify ]; then
    git clone https://github.com/MichaelAquilina/zsh-auto-notify.git ~/.local/zsh-auto-notify
fi

touch $HOME/.hushlogin

if [ -f $HOME/.zprofile ]; then
    /bin/mv $HOME/.zprofile $HOME/.zprofile.old
fi

if [ -f $HOME/.zlogin ]; then
    /bin/mv $HOME/.zlogin $HOME/.zlogin.old
fi
ln -s $HOME/.config/zsh/.zlogin $HOME/.zlogin

if [ -f $HOME/.zshenv ]; then
    /bin/mv $HOME/.zshenv $HOME/.zshenv.old
fi

if [ -f $HOME/.zshrc ]; then
    /bin/mv $HOME/.zshrc $HOME/.zshrc.old
fi
ln -s $HOME/.config/zsh/.zshrc $HOME/.zshrc
