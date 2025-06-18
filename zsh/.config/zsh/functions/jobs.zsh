#! /usr/bin/env zsh

function get_jobs() {
	cargo run --bin jobctl -- list | jq -r '
  def time_ago(timestamp):
    now as $now |
    ($now - timestamp) as $diff |
    if $diff < 60 then
      "\($diff | floor)s ago"
    elif $diff < 3600 then
      "\($diff / 60 | floor)m ago"
    elif $diff < 86400 then
      "\($diff / 3600 | floor)h ago"
    else
      "\($diff / 86400 | floor)d ago"
    end;
  
  .sessions[].jobs[] | 
  "\(.number): \(.command) (PID: \(.pid)) - \(time_ago(.suspended))"
'
}
