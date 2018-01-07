#!/usr/bin/env fish

function tn
  tmux new-session -s $argv
end
