#!/usr/bin/env fish

function tmux-list-and-attach
    set sessions (tmux list-session 2>/dev/null)
    set chosen_session ""
    set fzf_cmd "fzf --header '  Sessions' $TMUX_BORDER"

    if test -z "$sessions" || test -n "$TMUX" && test (echo "$sessions" | wc -l | tr -d ' ') -eq 1
        tmux-create-or-attach (select-git-project)
    else
        set chosen_session (tmux list-session | eval $fzf_cmd | cut -d: -f1)
    end

    if test -z "$chosen_session"
        return 0
    end

    if test -n "$TMUX"
        set current_session (tmux display-message -p '#S')
        if test "$chosen_session" != "$current_session"
            tmux switch-client -t "$chosen_session"
        end
    else
        tmux attach-session -t "$chosen_session"
    end
end
