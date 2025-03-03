# This is equivalent to .zprofile and .zshenv
eval (/opt/homebrew/bin/brew shellenv)

# Added by OrbStack: command-line tools and integration
if test -f ~/.orbstack/shell/init.fish
    source ~/.orbstack/shell/init.fish
end

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx EDITOR nvim
set -gx PATH "$HOME/.local/bin" $PATH
set -gx DOTFILES_PREFIX "$HOME/.dotfiles"
set -gx FISH_CONFIG "$HOME/.config/fish"

set -gx HISTFILE $HOME/.fish_history
set -gx HISTSIZE 99999
set -gx HISTFILESIZE 999999
set -gx SAVEHIST $HISTSIZE

# pnpm
set -gx PNPM_HOME "/Users/jonathan/Library/pnpm"
if not string match -q "*$PNPM_HOME*" $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# deno
set -gx PATH "$HOME/.deno/bin" $PATH

# go
set -gx GOPATH "$HOME/Developer/go"
set -gx PATH "$GOPATH/bin" $PATH

# nvm
set -gx NVM_DIR "$HOME/.nvm"
# Note: You'll need a fish NVM wrapper or equivalent

# BAT theme
set -gx BAT_THEME ansi

# man page colors
set -gx MANPAGER "less -sR --use-color -Dd+r -Du+b"

# fzf settings
set -gx FZF_CTRL_T_COMMAND ""
set -gx FZF_DEFAULT_OPTS "\
  --style minimal \
  --ansi \
  --bind 'ctrl-c:abort,ctrl-j:accept' \
  --border none \
  --color pointer:10,header:8 \
  --cycle \
  --height ~100% \
  --layout reverse \
  --tmux center \
  --info hidden"

# Add TMUX border if in TMUX
if set -q TMUX
    set -gx TMUX_BORDER "--border sharp"
    set -a FZF_DEFAULT_OPTS "--border sharp"
else
    set -gx TMUX_BORDER ""
end

set -gx FZF_CTRL_R_OPTS "\
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
  --header 'Press CTRL-Y to copy command into clipboard'"
