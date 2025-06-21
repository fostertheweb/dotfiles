#! /usr/bin/env zsh

function get_jobs() {
	cargo run --bin jobctl -- list $(pwd) |
		jq -r '.jobs[] | "\(.number):\(.pid) \(.command) - \(.suspended)"'
}

function get_sessions() {
	cargo run --bin jobctl -- list |
		jq -r '.sessions[] | (.directory | gsub(env.HOME; "~")) as $dir | "\($dir) - \(.jobs | length) job\(if (.jobs | length) == 1 then "" else "s" end)"'
}

# ctrl-t
# List current sessions and go to
bindkey -s '^T' '^M'

# ctrl-w
# Find project and create or attach
bindkey -s '^W' 'get_jobs^M'

# cmd-o
# Create "session"
bindkey -s '\eo' 'zoxide query --interactive^M'
