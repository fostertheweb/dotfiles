#!/usr/bin/env fish

function find-file
    set selected (fzf); and $EDITOR $selected
end
