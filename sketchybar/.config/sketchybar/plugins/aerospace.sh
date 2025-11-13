#!/usr/bin/env bash

source "$CONFIG_DIR/plugins/icon_map.sh"
source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
    background.color=$GRAY_TRANSPARENT \
    icon.color=$WHITE \
    label.color=$ACCENT
else
  sketchybar --set $NAME background.drawing=off \
    icon.color=$INACTIVE \
    label.color=$INACTIVE
fi

apps=$(aerospace list-windows --workspace $1 2>/dev/null | awk -F' \\| ' '{print $2}' | sort -u)

icon_string=""
if [ -n "$apps" ]; then
  for app in $apps; do
    __icon_map "$app"
    if [ "$icon_result" != ":default:" ]; then
      icon_string+="$icon_result"
    fi
  done
fi

if [ -n "$icon_string" ]; then
  sketchybar --set $NAME label="$icon_string" label.drawing=on
else
  sketchybar --set $NAME label.drawing=off
fi
