#!/usr/bin/env fish

set home_replacer "sed \"s|^$HOME|~|\""
set home_restore "sed \"s|^~|$HOME|\""
set find_command "fd --hidden --type d --max-depth 4 '.git' $HOME/Developer --exec dirname"
set fzf_git_cmd "fzf --header '  Projects' --keep-right $TMUX_BORDER"

function select-git-project
    eval $find_command | sort -u | eval $home_replacer | eval $fzf_git_cmd | eval $home_restore
end
