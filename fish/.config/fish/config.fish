alias oops="thefuck"
alias vim="nvim"
alias n="nvim"
# alias cat="bat"
alias ls="eza -la"
alias ll="eza -la"
alias tree="eza --tree -a"
alias history="history"
alias .="cd $HOME/.dotfiles"
alias todo="$FISH_CONFIG/functions/todo-cwd.fish"
alias lf="env OPENER=nvim lf"

# Initialize starship prompt
if command -v starship >/dev/null
    starship init fish | source
end

# Initialize thefuck
if command -v thefuck >/dev/null
    thefuck --alias | source
end

# Initialize zoxide
if command -v zoxide >/dev/null
    zoxide init fish | source
end

# Initialize fzf
if command -v fzf >/dev/null
    if test -f (brew --prefix)/opt/fzf/shell/key-bindings.fish
        source (brew --prefix)/opt/fzf/shell/key-bindings.fish
    end
end

# Initialize rbenv
if command -v rbenv >/dev/null
    status --is-interactive; and rbenv init - fish | source
end
