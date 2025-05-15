bindkey -e

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
export DOTFILES_PREFIX="$HOME/.dotfiles"
export ZSH_CONFIG="$HOME/.config/zsh"

# history configuration
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=99999
export HISTFILESIZE=999999
export SAVEHIST=$HISTSIZE

setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt monitor

# zsh-completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -U add-zsh-hook
autoload -Uz compinit && compinit -i

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# zsh plugins
source $HOME/.local/share/zsh/plugins/fzf-tab.plugin.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# fzf-tab configuration
zstyle ':fzf-tab:*' use-fzf-default-opts yes

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
export FZF_DEFAULT_OPTS="
  --style minimal
  --ansi
  --bind 'ctrl-c:abort,ctrl-j:accept'
  --border none
  --color pointer:10,header:8
  --cycle
  --height ~100%
  --layout reverse
  --tmux center
  --info hidden
  ${TMUX:+--border sharp}"
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'Press CTRL-Y to copy command into clipboard'"

# prompt
eval "$(starship init zsh)"

# thef*ck
eval "$(thefuck --alias)"

# zoxide
eval "$(zoxide init zsh)"

alias oops="fuck"
alias vim="nvim"
alias n="nvim"
alias ls="eza -la"
alias ll="eza -la"
alias tree="eza --tree -a"
alias history="fc -l 1"
alias .="cd $HOME/.dotfiles"
alias todo="$ZSH_CONFIG/bin/todo-cwd"
alias lf="OPENER=nvim lf"
alias ai="aider"

source "$ZSH_CONFIG/functions/extras.zsh"
source "$ZSH_CONFIG/functions/git.zsh"
source "$ZSH_CONFIG/functions/node.zsh"
source "$ZSH_CONFIG/functions/search.zsh"
source "$ZSH_CONFIG/functions/tmux.zsh"
source "$ZSH_CONFIG/functions/zellij.zsh"

source "$ZSH_CONFIG/keybinds.zsh"

add-zsh-hook chpwd load-nvmrc
