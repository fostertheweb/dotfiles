#!/usr/bin/env bash

source "$CONFIG_DIR/plugins/icon_map.sh"
source "$CONFIG_DIR/colors.sh"

icon_string=""
__icon_map "$1"
if [ "$icon_result" != ":default:" ]; then
  icon_string+="$icon_result"
fi

sketchybar --set $NAME \
  label.drawing=off \
  icon="$icon_string" \
  icon.drawing=on \
  icon.font="sketchybar-app-font:Regular:14.0" \
  icon.y_offset=-1

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
FOCUSED_APP=$(aerospace list-windows --focused $FOCUSED_WORKSPACE 2>/dev/null | awk -F' \\| ' '{print $2}')

if [ "$2" = "$FOCUSED_WORKSPACE" ]; then
  if [ "$1" = "$INFO" ]; then
    sketchybar --set $NAME \
      icon.color=$ACCENT
  else
    sketchybar --set $NAME \
      icon.color=$WHITE
  fi
else
  sketchybar --set $NAME \
    icon.color=$INACTIVE
fi
