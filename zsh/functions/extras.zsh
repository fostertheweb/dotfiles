#!/usr/bin/env zsh

function ttv() {
  local url="twitch.tv/$1"
  streamlink $url best --stream-url --twitch-disable-ads | xargs open -a "QuickTime Player.app"
  open -a Safari "https://$url/chat"
}

# yazi - change dir on exit
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
