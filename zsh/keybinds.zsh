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
# Open cwd in yazi
bindkey -s '\ef' 'yazi^M'

# cmd-e
# Open cwd in nvim
bindkey -s '\ee' 'nvim -c "Telescope git_files"^M'

# cmd-o
# Choose git branch
bindkey -s '\eo' 'select-git-branch^M'

# cmd-s
# Create tmux session
bindkey -s '\es' 'create-tmux-cwd-session^M'

# cmd-.
# Go to dotfiles
bindkey -s '\e.' 'cd $HOME/.dotfiles^M'

# cmd-g
# Grep in cwd
bindkey -s '\eg' 'grep-cwd^M'

# cmd-r
# Source zshrc
bindkey -s '\er' 'source $HOME/.zshrc^M'
