export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="fishy"

plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

export PATH=/usr/local/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

bindkey '^R' history-incremental-search-backward

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

