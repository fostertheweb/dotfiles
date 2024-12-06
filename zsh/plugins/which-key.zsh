#!/usr/bin/env zsh

# Custom widget to capture any key press
function which-key() {
	local key
	key=$(printf '%q' "$KEYS")
	echo "Key pressed: $key"
	zle reset-prompt # Refresh the prompt
}

# Bind the widget to all keys (catch-all)
zle -N any_key_listener
bindkey -v

for key in {a..z} {A..Z} {0..9} ' ' '^[' '^[O' '^[[' '^M'; do
	bindkey "$key" any_key_listener
done

which-key
