set home_replacer "sed \"s|^$HOME|~|\""
set home_restore "sed \"s|^~|$HOME|\""
set find_command "fd --hidden --type d --max-depth 4 '.git' $HOME/Developer --exec dirname"
set fzf_git_cmd_base "fzf --header '  Projects' --keep-right"

function select-git-project
    set fzf_git_cmd $fzf_git_cmd_base
    if set -q TMUX
        set fzf_git_cmd "$fzf_git_cmd --border sharp"
    end
    eval $find_command | sort -u | eval $home_replacer | eval $fzf_git_cmd | read -l selected_project
    if test -n "$selected_project"
        $selected_project | eval $home_restore 
    end
end
