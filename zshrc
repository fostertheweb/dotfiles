export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="fishy"

plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# add rbenv to PATH
export PATH="$HOME/.rbenv/bin:$PATH"

# load rbenv
eval "$(rbenv init -)"

bindkey '^R' history-incremental-search-backward

