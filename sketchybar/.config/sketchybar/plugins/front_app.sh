#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  BUNDLENAME=$(osascript -e "id of app \"$INFO\"")
  sketchybar --set $NAME background.drawing=on background.image.string="app.$BUNDLENAME"
fi
