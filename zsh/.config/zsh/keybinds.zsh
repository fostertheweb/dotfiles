#!/usr/bin/env zsh

# ctrl-z
# Bring bg process to the fg
bindkey -s '^Z' 'fg^M'

# ctrl-t
# List current sessions and attach
bindkey -s '^T' 'tmux-list-and-attach^M'

# cmd-o
# Find project and create or attach
bindkey -s '\eo' 'tmux-find-and-create-or-attach^M'

# cmd-f
# Find file with fzf
bindkey -s '\ef' 'find-file^M'

# cmd-e
# Open cwd in nvim
bindkey -s '\ee' 'nvim -c "ProjectFiles"^M'

# cmd-o
# Open ranger file manager
bindkey -s '\e/' 'ranger^M'

# cmd-s
# Create tmux session
bindkey -s '\es' 'create-tmux-cwd-session^M'

# cmd-d
# Go to dotfiles
bindkey -s '\ed' 'cd $HOME/.dotfiles^M'

# cmd-g
# Grep in cwd
bindkey -s '\eg' 'grep-cwd^M'

# cmd-shift-p
# Run zsh function
bindkey -s '\eP' 'run-zsh-fn^M'

# cmd-r
# Source zshrc
bindkey -s '\er' 'source $HOME/.zshrc^M'

# cmd-y
# Run GUI application
bindkey -s '\ey' 'run-app^M'
