#!/usr/bin/env zsh

function grep-cwd() {
  ag --hidden . | fzf -e -i | sed 's/^\([^:]*\):\([0-9]*\):.*/\+\2 \1/' | xargs $EDITOR
}

function find-file() {
  fzf | xargs $EDITOR
}
