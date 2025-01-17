#!/usr/bin/env zsh

# ctrl-z
# Bring bg process to the fg
bindkey -s '^Z' 'fg^M'

# ctrl-t
# List current sessions and attach
bindkey -s '^T' 'tmux-list-and-attach^M'

# cmd-t
# Find directory and create or attach
bindkey -s '\et' 'tmux-find-and-create-or-attach^M'

# cmd-f
# Open cwd in lf
bindkey -s '\ef' 'lf^M'

# cmd-e
# Open cwd in nvim
bindkey -s '\ee' 'nvim -c "ProjectFiles"^M'

# cmd-o
# Choose git branch
bindkey -s '\eo' 'select-git-branch^M'

# cmd-s
# Create tmux session
bindkey -s '\es' 'create-tmux-cwd-session^M'

# cmd-d
# Go to dotfiles
bindkey -s '\ed' 'cd $HOME/.dotfiles^M'

# cmd-g
# Grep in cwd
bindkey -s '\eg' 'grep-cwd^M'

# cmd-r
# Source zshrc
bindkey -s '\er' 'source $HOME/.zshrc^M'
