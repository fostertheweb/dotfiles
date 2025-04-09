export XDG_CONFIG_HOME="$HOME/.config"

export ANTHROPIC_API_KEY="$(op read 'op://Private/Anthropic API Key/credential')"

source "$HOME/.cargo/env"
