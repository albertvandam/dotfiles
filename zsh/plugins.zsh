case $CURRENT_OS in
    "UBUNTU_WSL")
      source ~/.local/zsh-you-should-use/you-should-use.plugin.zsh
      source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ;;

    "MACOS")
      source $HOMEBREW_PREFIX/share/zsh-you-should-use/you-should-use.plugin.zsh

      export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor)
      export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/highlighters
      source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      source $HOMEBREW_REPOSITORY/Library/Taps/homebrew/homebrew-command-not-found/handler.sh

      source ~/.local/zsh-auto-notify/auto-notify.plugin.zsh

      eval "$(direnv hook zsh)"
      eval "$(zoxide init zsh --hook pwd --cmd cd)"
      ;;
esac
