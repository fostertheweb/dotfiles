#! /usr/bin/env zsh

function get_jobs_shell() {
	jobctl list $(pwd) |
		jq -r '.jobs[] | "\(.number):\(.pid) \(.command) - \(.suspended)"'
}

function get_sessions_shell() {
	jobctl list |
		jq -r '.sessions[] | (.directory | gsub(env.HOME; "~")) as $dir | "\($dir) - \(.jobs | length) job\(if (.jobs | length) == 1 then "" else "s" end)"'
}

function get_jobs() {
	jobctl list $(pwd) --fzf
}

function get_sessions() {
	jobctl list --fzf
}

# ctrl-t
# List current sessions and go to
bindkey -s '^T' 'get_sessions^M'

# ctrl-w
# Find jobs and reattach
bindkey -s '^W' 'get_jobs^M'

# cmd-o
# Create "session"
bindkey -s '\eo' 'zoxide query --interactive^M'
