#!/usr/bin/env zsh

current_workspace=$(aerospace list-workspaces --focused)
windows=$(aerospace list-windows --workspace $current_workspace --json)
title=$(echo $windows | jq -r '.[] | select(."window-id" == '"$1"') | ."window-title"')
app=$(echo $windows | jq -r '.[] | select(."window-id" == '"$1"') | ."app-name"')

if [[ "$1" == $(aerospace list-windows --focused --json | jq -r '.[]' | jq -r '."window-id"') ]]; then
  if [[ "$app" == "Ghostty" ]]; then
    sketchybar --set $NAME label=$title background.drawing=on
  else
    sketchybar --set $NAME label=$app background.drawing=on
  fi
else
  if [[ "$app" == "Ghostty" ]]; then
    sketchybar --set $NAME label=$title background.drawing=off
  else
    sketchybar --set $NAME label=$app background.drawing=off
  fi
fi
