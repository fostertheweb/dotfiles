set -gx XDG_CONFIG_HOME "$HOME/.config"

if test -f "$HOME/.api-credentials"
    source "$HOME/.api-credentials"
end
