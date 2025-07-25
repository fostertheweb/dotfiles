#!/usr/bin/env zsh

bindkey ^p history-search-backward
bindkey ^n history-search-forward

# ctrl-z
# Bring bg process to the fg
bindkey -s '^Z' 'fg^M'

# ctrl-o
# Jump to last directory
bindkey -s '^o' 'cd -^M'

# ctrl-g
# open gitu
bindkey -s '^g' 'gitu^M'

# ctrl-J
# open lazyjj
bindkey -s '^[[106;6u' 'lazyjj^M'

# cmd-f
# Find file with fzf
bindkey -s '\ef' 'find-file^M'

# cmd-e
# Open cwd in nvim
bindkey -s '\ee' 'nvim -c "ProjectFiles"^M'

# cmd -
# Open ranger file manager
bindkey -s '\e-' 'ranger^M'

# cmd-d
# Go to dotfiles
bindkey -s '\ed' 'cd $HOME/.dotfiles^M'

# cmd-i
# launch opencode
bindkey -s '\ei' 'opencode^M'

# cmd-/
# Grep in cwd
bindkey -s '\e/' 'grep-cwd^M'

# cmd-shift-p
# Run zsh function
bindkey -s '\eP' 'run-zsh-fn^M'

# cmd-r
# Source zshrc
bindkey -s '\er' 'source $HOME/.zshrc^M'

# cmd-y
# Run GUI application
bindkey -s '\ey' 'run-app^M'

# cmd-u
bindkey -s '\eu' 'git pull^M'
