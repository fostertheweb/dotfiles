#!/bin/sh

source "$CONFIG_DIR/colors.sh"

sketchybar --set "$NAME" \
  background.drawing=on \
  background.color="0x55000000" \
  background.corner_radius=8 \
  background.height=25 \
  label="$(date '+%H:%M')" \
  label.color="$WHITE" \
  label.padding_left=10 \
  icon.drawing=off
