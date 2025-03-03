#!/usr/bin/env fish

function run-zsh-fn
    set user_funcs
    
    for func in (functions -n)
        if not string match -q "_*" "$func"
            set -a user_funcs $func
        end
    end

    set selected (printf "%s\n" $user_funcs | sort | fzf --prompt="Run Command: ")

    if test -n "$selected"
        eval $selected
    end
end
