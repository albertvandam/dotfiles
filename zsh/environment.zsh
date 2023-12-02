if [[ $(uname) == "Darwin" ]]; then
    export CURRENT_OS="MACOS"
fi
if [[ "$WSL_DISTRO_NAME" == "Ubuntu" ]]; then
    export CURRENT_OS="UBUNTU_WSL"
fi

case $CURRENT_OS in
    "UBUNTU_WSL")
        export PATH="/snap/bin:$PATH"
        export PROJECTS="/mnt/c/Projects"
        ;;

    "MACOS")
        export PATH="$HOME/.local/maven/apache-maven-3.9.5/bin:$PATH"
        export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"
        export PATH="$HOME/.rd/bin:$PATH"
        export MAVEN_HOME="$HOME/.local/maven/apache-maven-3.9.5"
        export PROJECTS="$HOME/Projects"
        ;;
esac

# Set the editor
export EDITOR="vi"
export VISUAL="vi"

# Set the PAGER
export PAGER='less'
export LESS='-g -i -M -R -S -w -z-4'
export LESSHISTFILE="$HOME/.history/less"

# Bat (cat replacement)
export BAT_THEME="Dracula" 
export BAT_STYLE="full"

# Enable colours
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

autoload -U colors
colors

# Smart URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# General
setopt BRACE_CCL          # Allow brace character class list expansion.
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.

# Jobs
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

setopt glob_dots     # no special treatment for file names with a leading dot

precmd_title () {
    print -Pn "\e]0;%~\a"
}
preexec_title() {
    local current_cmd=$(echo $1 | xargs)
    print -Pn "\e]0;%~ :: $current_cmd\a"
}
autoload -U add-zsh-hook
add-zsh-hook precmd precmd_title
add-zsh-hook preexec preexec_title

for file in $(find ~/.local/zsh_config -type f -name "*.env" ); 
do
    source $file
done
