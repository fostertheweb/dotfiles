export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="fishy"

plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# load rbenv
eval "$(rbenv init -)"

bindkey '^R' history-incremental-search-backward

