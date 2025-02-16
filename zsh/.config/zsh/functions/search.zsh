#!/usr/bin/env zsh

function grep-cwd() {
  $EDITOR "$(ag --hidden . | fzf -e -i | sed 's/^\([^:]*\):\([0-9]*\):.*/\+\2 \1/')"
}

function find-file() {
  $EDITOR "$(fzf)"
}
