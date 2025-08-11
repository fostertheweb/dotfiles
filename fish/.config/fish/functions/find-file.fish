function find-file
    set selection (fzf)

    if test -n "$selection"
        $EDITOR $selection
    end
end