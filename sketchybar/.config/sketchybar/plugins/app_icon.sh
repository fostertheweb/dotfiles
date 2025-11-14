#!/bin/sh

source "$CONFIG_DIR/colors.sh"

if [ "$1" = "$INFO" ]; then
  sketchybar --set $NAME \
    icon.color=$ACCENT
else
  sketchybar --set $NAME \
    icon.color=$WHITE
fi
