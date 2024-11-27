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
export FZF_DEFAULT_OPTS='--height 40% --tmux center --layout reverse --border'

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

# tmux
tmux_attach_or_create() {
  local path="${1:-$(basename `git rev-parse --show-toplevel`)}"
  local session_name="${path##*/}"
  local safe_name="${session_name//./_}"

  if tmux has-session -t "$session_name" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      local current_session="$(tmux display-message -p '#S')"
      if [[ "$session_name" != "$current_session" ]]; then
	tmux switch-client -t "$session_name"
      fi
    else
      tmux attach-session -t "$session_name"
    fi
  else
    if [[ -n "$TMUX" ]]; then
      tmux new-session -d -s "$session_name" -c "$path"
      tmux switch-client -t "$session_name"
    else
      tmux new-session -s "$session_name" -c "$path"
    fi
  fi
}

alias t=tmux_attach_or_create

find_dir_and_create_or_attach() {
  tmux_attach_or_create "$(zoxide query --interactive)"
}

alias tn=find_dir_and_create_or_attach

tmux_list_and_attach() {
  local chosen_session="$(tmux list-session | fzf | cut -d: -f1)"

  if [[ -n "$TMUX" ]]; then
    local current_session="$(tmux display-message -p '#S')"
    if [[ "$chosen_session" != "$current_session" ]]; then
      tmux switch-client -t "$chosen_session"
    fi
  else
    tmux attach-session -t "$chosen_session"
  fi
}

# create ZLE widget
zle -N tmux_list_and_attach{,}
bindkey -s '^T' 'tmux_list_and_attach^M'
