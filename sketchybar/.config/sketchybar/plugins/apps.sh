#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/icon_map.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
FOCUSED_APP=$(aerospace list-windows --focused $FOCUSED_WORKSPACE 2>/dev/null | awk -F' \\| ' '{print $2}')

apps=$(aerospace list-windows --workspace $FOCUSED_WORKSPACE 2>/dev/null | awk -F' \\| ' '{print $2}' | sort -u)

if [ -n "$apps" ]; then
  for app in $apps; do

    icon_string=""
    __icon_map "$app"
    if [ "$icon_result" != ":default:" ]; then
      icon_string+="$icon_result"
    fi

    sketchybar --add item app.$app left \
      --subscribe app.$app front_app_switched \
      --set app.$app \
      label.drawing=off \
      icon.drawing=on \
      icon="$icon_string" \
      icon.color=$INACTIVE \
      icon.font="sketchybar-app-font:Regular:14.0" \
      icon.y_offset=-1 \
      script="$CONFIG_DIR/plugins/app_icon.sh $app $FOCUSED_WORKSPACE" \
      y_offset=1

  done
fi
