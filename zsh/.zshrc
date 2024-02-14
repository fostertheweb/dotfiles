bindkey -e

export EDITOR=nvim

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

# go
export GOPATH="$HOME/Developer/go"
export PATH="$GOPATH/bin:$PATH"

alias z="zoxide"
alias f="zoxide"
eval "$(z init zsh)"
alias ls="eza -la"
alias history="fc -l 1"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# bun completions
[ -s "/Users/jonathan/.bun/_bun" ] && source "/Users/jonathan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
