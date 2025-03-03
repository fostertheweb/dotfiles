#!/usr/bin/env fish

function grep-cwd
    set selection (ag --hidden . | fzf -e -i)
    if test -n "$selection"
        set file (echo "$selection" | sed -E 's/^([^:]*):([0-9]*):.*/\1/')
        set line (echo "$selection" | sed -E 's/^([^:]*):([0-9]*):.*/\2/')
        $EDITOR +$line "$file"
    end
end
