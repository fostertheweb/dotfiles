bindkey -e

export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# history configuration
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=99999
export HISTFILESIZE=999999
export SAVEHIST=$HISTSIZE

setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

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
eval "$(zoxide init zsh)"

# deno
export PATH="$HOME/.deno/bin:$PATH"

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/jonathan/.zsh/completions:"* ]]; then export FPATH="/Users/jonathan/.zsh/completions:$FPATH"; fi

# go
export GOPATH="$HOME/Developer/go"
export PATH="$GOPATH/bin:$PATH"

# thef*ck
eval "$(thefuck --alias)"
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
alias .='cd $HOME/.dotfiles'

# man page colors
export MANPAGER="less -sR --use-color -Dd+r -Du+b"

# fzf shell integration
source <(fzf --zsh)
export FZF_CTRL_T_COMMAND=""
# Open in tmux popup if on tmux, otherwise use --height mode
export FZF_DEFAULT_OPTS='--height 60% --tmux center --layout reverse --border'

alias b="git branch -v | fzf | sed -E 's/^[* ]+([a-zA-Z0-9_-]+).*/\1/' | xargs git checkout"
alias f="ag . | fzf -e -i | sed 's/^\([^:]*\):\([0-9]*\):.*/\+\2 \1/' | xargs $EDITOR"

# ruby
eval "$(rbenv init - zsh)"

function ttv() {
    local url="twitch.tv/$1"
    streamlink $url best --stream-url --twitch-disable-ads | xargs open -a "QuickTime Player.app"
    open -a Safari "https://$url/chat"
}

# change dir on exit
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# automatic nvm use
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

function create_worktree() {
  if [[ -z "$1" ]]; then
    echo "Error: New worktree name required" >&2
    return 1
  fi

  local trunk=$(git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
  local worktree=$(pwd | sed "s/$(basename "$(pwd)")/$(basename `pwd`)@$1/")
  git worktree add $worktree $trunk
  cd $worktree
  git status
}

# open tmux-tea
bindkey -s '^T' ' tea^M ^M'

