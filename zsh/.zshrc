export EDITOR=hx

# opam setup
[[ ! -r /Users/jonathan/.opam/opam-init/init.zsh ]] || source /Users/jonathan/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# pnpm
export PNPM_HOME="/Users/jonathan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun completions
[ -s "/Users/jonathan/.bun/_bun" ] && source "/Users/jonathan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zsh plugins
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# prompt
eval "$(starship init zsh)"

# go
export GOPATH="$HOME/Developer/go"
export PATH="$GOPATH/bin:$PATH"

alias z="zoxide"
eval "$(z init zsh)"
alias ls="eza -la"
