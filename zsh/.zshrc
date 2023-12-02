# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/environment.zsh
source ~/.config/zsh/directories.zsh
source ~/.config/zsh/history.zsh
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/prompt.zsh

for file in $(find ~/.local/zsh_config -type f -name "*.zsh" ); 
do
    source $file
done
