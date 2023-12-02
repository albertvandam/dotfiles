export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='-i --height=30% --reverse --border --border-label="╢ $label ╟" --color=label:italic:black'   

if [[ "$CURRENT_OS" == "UBUNTU_WSL" ]]; then
    # ---------
    if [[ ! "$PATH" == *$HOME/.local/.fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}$HOME/.local/.fzf/bin"
    fi

    # Auto-completion
    # ---------------
    source "$HOME/.local/.fzf/shell/completion.zsh"

    # Key bindings
    # ------------
    source "$HOME/.local/.fzf/shell/key-bindings.zsh"
fi

if [[ "$CURRENT_OS" == "MACOS" ]]; then
    # ---------
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
        PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi

    # Auto-completion
    # ---------------
    source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"

    # Key bindings
    # ------------
    source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi
