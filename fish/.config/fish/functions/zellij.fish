#!/usr/bin/env fish

function create-zellij-cwd-session
    zellij -s (basename (pwd))
end

function zellij-create-or-attach
    set dir $argv[1]

    if test -n "$dir"
        set session_name (basename "$dir")
    else
        return 0
    end

    if tmux has-session -t "=$session_name" 2>/dev/null
        if test -n "$ZELLIJ"
            if test "$session_name" != (tmux display-message -p '#S')
                tmux switch-client -t "$session_name"
            end
        else
            tmux attach-session -t "$session_name"
        end
    else
        if test -n "$ZELLIJ"
            tmux new-session -d -s "$session_name" -c "$dir"
            tmux switch-client -t "$session_name"
        else
            tmux new-session -s "$session_name" -c "$dir"
        end
    end
end

set home_replacer "sed \"s|^$HOME|~|\""
set home_restore "sed \"s|^~|$HOME|\""
set find_command "fd --hidden --type d --max-depth 4 '.git' $HOME/Developer --exec dirname"

function select-git-project
    eval $find_command | sort -u | eval $home_replacer | fzf --keep-right --border-label " Git Projects " --prompt " : " | eval $home_restore
end

function zellij-find-and-create-or-attach
    zellij-create-or-attach (select-git-project)
end

function zellij-list-and-attach
    set sessions (tmux list-session 2>/dev/null)
    set chosen_session ""

    if test -z "$sessions" || test -n "$ZELLIJ" && test (echo "$sessions" | wc -l | tr -d ' ') -eq 1
        zellij-create-or-attach (select-git-project)
    else
        set chosen_session (zellij list-sessions | fzf --border-label ' Sessions ' --prompt ' : ' | cut -d' ' -f1)
    end

    if test -z "$chosen_session"
        return 0
    end

    if test -n "$ZELLIJ"
        set current_session (tmux display-message -p '#S')
        if test "$chosen_session" != "$current_session"
            tmux switch-client -t "$chosen_session"
        end
    else
        tmux attach-session -t "$chosen_session"
    end
end
