#!/usr/bin/env zsh

function ttv() {
  local url="twitch.tv/$1"
  streamlink $url best --stream-url --twitch-disable-ads | xargs open -a "QuickTime Player.app"
  open -a Safari "https://$url/chat"
}

function run-zsh-fn() {
  local user_funcs=()
  local func

  for func in ${(k)functions}; do
    if [[ "$func" != _* ]]; then
      user_funcs+="$func"
    fi
  done

  local selected
  selected=$(printf "%s\n" "${user_funcs[@]}" | sort | fzf --prompt="Run Command: ")

  if [[ -n "$selected" ]]; then
    $selected
  fi
}
