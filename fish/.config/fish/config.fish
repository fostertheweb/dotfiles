# Environment variables
set -gx EDITOR nvim
fish_add_path "$HOME/.local/bin"
set -gx DOTFILES_PREFIX "$HOME/.dotfiles"
set -gx FISH_CONFIG "$HOME/.config/fish"

# History configuration
# set -g fish_history_max 99999

# pnpm
set -gx PNPM_HOME "/Users/jonathan/Library/pnpm"
if not contains "$PNPM_HOME" $PATH
    fish_add_path "$PNPM_HOME"
end

# deno
fish_add_path "$HOME/.deno/bin"

# go
set -gx GOPATH "$HOME/Developer/go"
fish_add_path "$GOPATH/bin"

# ruby - rbenv init
if command -v rbenv > /dev/null
    rbenv init - fish | source
end

# nvm - fish equivalent
set -gx NVM_DIR "$HOME/.nvm"
if test -s "$NVM_DIR/nvm.sh"
    if command -v bass > /dev/null
        load_nvm > /dev/stderr
    end
end

# OCaml
if test -r '/Users/jonathan/.opam/opam-init/init.fish'
    source '/Users/jonathan/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
end

set -gx BAT_THEME ansi

# man page colors
set -gx MANPAGER "less -sR --use-color -Dd+r -Du+b"

# fzf shell integration
if command -v fzf > /dev/null
    fzf --fish | source
    
    # Disable fzf Ctrl-T binding
    set -gx FZF_CTRL_T_COMMAND ""
    
    # Open in tmux popup if on tmux, otherwise use --height mode
    set -gx FZF_DEFAULT_OPTS "
  --style minimal
  --ansi
  --bind 'ctrl-c:abort,ctrl-j:accept'
  --border none
  --color pointer:10,header:8
  --cycle
  --height ~100%
  --layout reverse
  --tmux center
  --info hidden"
    
    if set -q TMUX
        set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --border sharp"
    end
    
    set -gx FZF_CTRL_R_OPTS "
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'Press CTRL-Y to copy command into clipboard'"
end

# thef*ck
if command -v thefuck > /dev/null
    thefuck --alias | source
end

# zoxide
if command -v zoxide > /dev/null
    zoxide init fish | source
end

# Aliases
alias oops="fuck"
alias vim="nvim"
alias n="nvim"
alias ls="eza -la"
alias ll="eza -la"
alias tree="eza --tree -a"
alias .="cd $HOME/.dotfiles"
alias todo="$FISH_CONFIG/bin/todo-cwd"
alias lf="env OPENER=nvim lf"
alias ai="opencode"

# Load custom key bindings
if test -f "$FISH_CONFIG/functions/fish_user_key_bindings.fish"
    fish_user_key_bindings
end
