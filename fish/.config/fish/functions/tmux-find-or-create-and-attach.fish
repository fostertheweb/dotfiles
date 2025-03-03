#!/usr/bin/env fish

function tmux-find-and-create-or-attach
    tmux-create-or-attach (select-git-project)
end
