bindkey -e

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
export DOTFILES_PREFIX="$HOME/.dotfiles"

# history configuration
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=99999
export HISTFILESIZE=999999
export SAVEHIST=$HISTSIZE

setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

autoload -U add-zsh-hook

# pnpm
export PNPM_HOME="/Users/jonathan/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# zsh plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# prompt
eval "$(starship init zsh)"

# deno
export PATH="$HOME/.deno/bin:$PATH"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/jonathan/.zsh/completions:"* ]]; then export FPATH="/Users/jonathan/.zsh/completions:$FPATH"; fi

# go
export GOPATH="$HOME/Developer/go"
export PATH="$GOPATH/bin:$PATH"

# thef*ck
eval "$(thefuck --alias)"

# zoxide
eval "$(zoxide init zsh)"

# man page colors
export MANPAGER="less -sR --use-color -Dd+r -Du+b"

# fzf shell integration
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND=""
# Open in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS='--height 60% --tmux center --layout reverse --border'

# ruby
eval "$(rbenv init - zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

alias t="tmux new -s $(basename `pwd`)"
alias b="git branch -v | fzf | sed -E 's/^[* ]+([a-zA-Z0-9_-]+).*/\1/' | xargs git checkout"
alias f="ag . | fzf -e -i | sed 's/^\([^:]*\):\([0-9]*\):.*/\+\2 \1/' | xargs $EDITOR"
alias .='cd $HOME/.dotfiles'

alias oops="fuck"
alias vim="nvim"
alias n="nvim"
alias p="nvim ."
alias cat="bat"
alias c="cat"
alias ls="eza -la"
alias ll="eza -la"
alias tree="eza --tree -a"
alias history="fc -l 1"
alias e="yazi"

source "$DOTFILES_PREFIX/zsh/scripts/extras.zsh"
source "$DOTFILES_PREFIX/zsh/scripts/git.zsh"
source "$DOTFILES_PREFIX/zsh/scripts/node.zsh"
source "$DOTFILES_PREFIX/zsh/scripts/tmux.zsh"

add-zsh-hook chpwd load-nvmrc

# Ctrl-T
# List current sessions and attach
bindkey -s '^T' ' tmux-list-and-attach^M ^M'

# Alt-T
# Find directory and create or attach
bindkey -s '^[t' ' tmux-find-and-create-or-attach^M ^M'

# Alt-O
# Open cwd in nvim
bindkey -s '^[o' 'nvim .^M'
