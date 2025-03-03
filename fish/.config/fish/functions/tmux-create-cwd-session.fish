#!/usr/bin/env fish

function tmux-create-cwd-session
    tmux new -s (basename (pwd))
end




