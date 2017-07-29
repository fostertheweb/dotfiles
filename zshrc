export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="fishy"

plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

# Path Configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH=~/Library/Python/3.6/bin:$PATH
export GOPATH="$HOME/Source/go"
export PATH="$GOPATH/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vim="nvim"
alias vimrc="nvim ~/.vim/nvimrc"
alias tmux="tmux -2"

bindkey '^R' history-incremental-search-backward

eval $(thefuck --alias)
