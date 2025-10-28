zmodload zsh/zprof

bindkey -e

export EDITOR=nvim
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

# homebrew zsh-completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -U add-zsh-hook

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -i
else
  compinit -C
fi

# fzf-tab configuration
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# pnpm
export PNPM_HOME="/Users/jonathan/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# go
export GOPATH="$HOME/Developer/go"

# update PATH
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$GOPATH/bin:$HOME/.deno/bin:$PATH"

export BAT_THEME=ansi

# man page colors
export MANPAGER="less -sR --use-color -Dd+r -Du+b"

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

# ruby
eval "$(rbenv init - zsh)"

alias oops="fuck"
alias vim="nvim"
alias ed="nvim"
alias ls="eza -la"
alias ll="eza -la"
alias tree="eza --tree -a"
alias history="fc -l 1"
alias .="cd $HOME/.dotfiles"
alias todo="$ZSH_CONFIG/bin/todo-cwd"
alias journal="$ZSH_CONFIG/bin/journal"
alias ai="opencode"
alias merge="nvim -c GitConflictListQf"

source "$ZSH_CONFIG/functions/extras.zsh"
source "$ZSH_CONFIG/functions/git.zsh"
source "$ZSH_CONFIG/functions/jobs.zsh"
source "$ZSH_CONFIG/functions/node.zsh"
source "$ZSH_CONFIG/functions/opencode.zsh"
source "$ZSH_CONFIG/functions/search.zsh"

source "$ZSH_CONFIG/keybinds.zsh"

add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# Essential plugins loaded immediately (needed for interactive use)
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

_lazy_load_plugins() {
  if [[ -z "$_PLUGINS_LOADED" ]]; then
    source <(fzf --zsh)
    source $HOME/.local/share/zsh/plugins/fzf-tab.plugin.zsh
    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    export _PLUGINS_LOADED=1
  fi
}

# For interactive shells, set up lazy loading
# Load plugins after first prompt is shown
# For non-interactive shells, load immediately
if [[ $- == *i* ]]; then
  _lazy_load_once() {
    _lazy_load_plugins
    add-zsh-hook -d precmd _lazy_load_once
    unfunction _lazy_load_once 2>/dev/null
  }
  add-zsh-hook precmd _lazy_load_once
else
  _lazy_load_plugins
fi

# Show profiling info on demand with `zprof` command
