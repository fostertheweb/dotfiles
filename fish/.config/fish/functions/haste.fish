#!/usr/bin/env fish

function haste
  set -l cwd
  set -l project

  if count $argv > /dev/null
    set cwd $argv
  else
    set cwd (echo $PWD)
  end
 
  set project (basename $cwd)

  if string split "." -- $project
    set project (string split "." -- $project)[-1]
  end

  tmux start-server
  tmux new-session -d -c $cwd -s $project -n server
  tmux new-window -t $project:2 -n editor

  tmux send-keys -t $project:2 "nvim ." C-m
  tmux send-keys -t $project:2 ":Tmuxline" C-m

  tmux select-window -t $project:1
  tmux attach-session -t $project
end
