#!/usr/bin/env zsh

bindkey ^p history-search-backward
bindkey ^n history-search-forward

# ctrl-z
# Bring bg process to the fg
bindkey -s '^Z' 'fg^M'

# ctrl-o
# Jump to last directory
bindkey -s '^o' 'cd -^M'

# cmd+r
# open pr review worktree
bindkey -s '\er' 'cd $(get-or-create-worktree)^M'

# cmd+g
# open gh dash
bindkey -s '\eg' 'gh dash^M'

# ctrl-g
# open gitu
bindkey -s '^g' 'gitu^M'

# cmd-f
# Open fzf in cwd
bindkey -s '\ef' 'find-file^M'

# cmd-e
# Open nvim
bindkey -s '\ee' 'nvim^M'

# cmd -
# Open superfile to navigate files
bindkey -s '\e-' 'spf^M'

# cmd-d
# Go to dotfiles
bindkey -s '\ed' 'cd $HOME/.dotfiles^M'

# cmd-i
# launch opencode
bindkey -s '\ei' 'opencode^M'

# cmd-/
# Grep in cwd
bindkey -s '\e/' 'grep-cwd^M'

# cmd-s
# Source zshrc
bindkey -s '\es' 'source $HOME/.zshrc^M'

# cmd-y
# Run GUI application
bindkey -s '\ey' 'run-app^M'

# cmd-u
bindkey -s '\eu' 'git pull^M'

# cmd-j
bindkey -s '\ej' 'journal^M'
