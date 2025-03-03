#!/usr/bin/env fish

function tmux-create-or-attach
    set dir $argv[1]

    if test -n "$dir"
        set session_name (basename "$dir")
    else
        return 0
    end

    # safe session name
    set session_name (string replace -a "." "_" "$session_name")

    if tmux has-session -t "=$session_name" 2>/dev/null
        if test -n "$TMUX"
            if test "$session_name" != (tmux display-message -p '#S')
                tmux switch-client -t "$session_name"
            end
        else
            tmux attach-session -t "$session_name"
        end
    else
        if test -n "$TMUX"
            tmux new-session -d -s "$session_name" -c "$dir"
            tmux switch-client -t "$session_name"
        else
            tmux new-session -s "$session_name" -c "$dir"
        end
    end
end
