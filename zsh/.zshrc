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

# zsh plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# pnpm
export PNPM_HOME="/Users/jonathan/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# deno
export PATH="$HOME/.deno/bin:$PATH"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/jonathan/.zsh/completions:"* ]]; then export FPATH="/Users/jonathan/.zsh/completions:$FPATH"; fi

# go
export GOPATH="$HOME/Developer/go"
export PATH="$GOPATH/bin:$PATH"

# ruby
eval "$(rbenv init - zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# OCaml
[[ ! -r '/Users/jonathan/.opam/opam-init/init.zsh' ]] || source '/Users/jonathan/.opam/opam-init/init.zsh' >/dev/null 2>/dev/null

export BAT_THEME=ansi

# man page colors
export MANPAGER="less -sR --use-color -Dd+r -Du+b"

# fzf shell integration
source <(fzf --zsh)
# Disable fzf Ctrl-T binding
export FZF_CTRL_T_COMMAND=""
# Open in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS="--ansi --bind 'ctrl-c:abort,ctrl-j:accept' --cycle --height 60% --tmux center --layout reverse --margin 1,0 --border --border-label-pos 2"

# prompt
eval "$(starship init zsh)"

# thef*ck
eval "$(thefuck --alias)"

# zoxide
eval "$(zoxide init zsh)"

alias oops="fuck"
alias vim="nvim"
alias n="nvim"
# alias cat="bat"
alias ls="eza -la"
alias ll="eza -la"
alias tree="eza --tree -a"
alias history="fc -l 1"
alias .="cd $HOME/.dotfiles"
alias todo="$DOTFILES_PREFIX/zsh/bin/todo-cwd"
alias lf="OPENER=nvim lf"

source "$DOTFILES_PREFIX/zsh/functions/extras.zsh"
source "$DOTFILES_PREFIX/zsh/functions/git.zsh"
source "$DOTFILES_PREFIX/zsh/functions/node.zsh"
source "$DOTFILES_PREFIX/zsh/functions/search.zsh"
source "$DOTFILES_PREFIX/zsh/functions/tmux.zsh"

source "$DOTFILES_PREFIX/zsh/keybinds.zsh"

add-zsh-hook chpwd load-nvmrc
