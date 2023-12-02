#  ~/.zlogin

# Executed on startin the background, so won't afftect current session
# Credit @htr3n. More info: https://htr3n.github.io/2018/07/faster-zsh/

{
    # Compile .zcompdump file, if modified, to increase startup speed
    zcompdump="$HOME/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]];
    then
        zcompile "$zcompdump"
    fi

    # Set environment variables for launchd processes.
    if [[ "$OSTYPE" == darwin* ]]; then
        for env_var in PATH MANPATH; do
            launchctl setenv "$env_var" "${(P)env_var}" 2>/dev/null
        done
    fi
} &!
