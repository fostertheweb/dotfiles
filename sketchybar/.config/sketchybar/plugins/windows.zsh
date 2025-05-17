#!/usr/bin/env zsh

current_workspace=$(aerospace list-workspaces --focused)
windows=$(aerospace list-windows --workspace $current_workspace --json)

for pid in $(echo $windows | jq -r '.[]."window-id"'); do
  sketchybar --add item window.$pid left \
    --subscribe window.$pid aerospace_focus_change \
    --set window.$pid \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.height=20 \
    background.drawing=off \
    icon.drawing=off \
    padding_right=8 \
    script="$CONFIG_DIR/plugins/window-title.zsh $pid"
done
