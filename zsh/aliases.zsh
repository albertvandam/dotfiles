# show list of recent directories
alias d='dirs -v'

# 1 = go to index #1 from recent directories
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# directory listings
alias ls="lsd"                    # replace ls with lsd
alias la="ll -A"                  # long list including hidden files 
alias ll="ls --long"              # long list of files with details without hidden files
alias lt="ls --tree -I node_modules -I dist -I target -I .git -I .angular -I .vscode -I .idea"
alias l="ls"                      # list files in grid
alias tree="lt"                   # show a tree

# utilities
alias diff="delta"
alias p="pwd"
alias c="clear"
alias cls="c;ls"
alias which="which -a"

# request confirmation and show what is done
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# grep with colours
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# editor
alias e='code'

# Resource Usage
alias df='df -kh'
alias du='du -kh'
alias top='btop'

# Weather
alias weather='zsh ~/.config/zsh/scripts/getweather.zsh && /bin/cat /tmp/weather-now'
alias forecast='source ~/.local/zsh_config/location.env && curl -s "wttr.in/$LOCATION"'

# GIT
# Make git commit with -m
function gcommit {
  commit_msg=$@
  if [ $# -eq 0 ]; then
    echo 'Enter a commit message';
    read commit_msg;
  fi
  git commit -m "$commit_msg" --no-verify
}

alias gcm="gcommit"
alias gs="git status"
alias gb="git b"
alias gl="git l"
alias gp="git push"
alias gpu="git pull"
alias ga='git add .'

function gg {
    git pull && git add . && gcommit $@ && git push
}

#Node
alias nn="/bin/rm -rfI node_modules package-lock.json && npm cache clear --force && npm install --force"
alias ni="npm cache clear --force && npm install --force"
alias ng="npx ng"

# dev utility
alias build="if [ -e package.json ]; then npm run check; else mvn clean verify; fi"

# OS Specific aliases
case $CURRENT_OS in
    "UBUNTU_WSL")
      alias cat='batcat'
      alias o='explorer.exe'
      alias explore='explorer.exe .'
      alias docker='sudo docker'
      ;;

    "MACOS")
        alias cat='bat'
        alias o='open'
        alias finder="o \$PWD"
        alias cpwd='pwd | pbcopy' # Copy current path
        alias upd='bash ~/.config/Install/update/prepare.sh'
      ;;
esac
