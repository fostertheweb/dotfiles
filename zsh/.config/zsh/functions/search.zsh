#!/usr/bin/env zsh

function grep-cwd() {
  ag . | fzf -e -i | sed 's/^\([^:]*\):\([0-9]*\):.*/\+\2 \1/' | xargs $EDITOR
}
