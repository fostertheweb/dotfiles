#! /usr/bin/env zsh

function get_jobs() {
	cargo run --bin jobctl -- list $(pwd) |
		jq -r '.jobs[] | "\(.number):\(.pid) \(.command) - \(.suspended)"'
}

function get_sessions() {
	cargo run --bin jobctl -- list |
		jq -r '.sessions[] | (.directory | gsub(env.HOME; "~")) as $dir | "\($dir) - \(.jobs | length) job\(if (.jobs | length) == 1 then "" else "s" end)"'
}
