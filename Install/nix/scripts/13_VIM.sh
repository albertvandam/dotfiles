echo "Configuring Vim"

/bin/rm -rf $HOME/.vim
/bin/rm -f $HOME/.vimrc
ln -s $HOME/.config/Vim/.vim $HOME/.vim
ln -s $HOME/.config/Vim/.vimrc $HOME/.vimrc

