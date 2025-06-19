#! /usr/bin/env zsh

function get_jobs() {
	cargo run --bin jobctl -- list | jq -r '.sessions[].jobs[] | "\(.number): \(.command) (PID: \(.pid)) - \(.suspended)"'
}
