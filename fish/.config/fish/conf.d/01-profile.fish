if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

if test -f "$HOME/.orbstack/shell/init.fish"
    source "$HOME/.orbstack/shell/init.fish" 2>/dev/null; or true
end
