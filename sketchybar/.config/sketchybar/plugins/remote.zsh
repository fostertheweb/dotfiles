#!/usr/bin/env zsh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

eval "$(zoxide init zsh)"
source "$ZSH_CONFIG/functions/git.zsh"

local current_workspace=$(aerospace list-workspaces --focused)

sketchybar --set "$NAME" label="$(origin-status $current_workspace 2>/dev/null)"
