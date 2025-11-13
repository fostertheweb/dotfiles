#!/bin/sh

source "$CONFIG_DIR/colors.sh"

sketchybar --set "$NAME" \
  label="$(date '+%H:%M')" \
  label.color="$WHITE" \
  icon.drawing=off
