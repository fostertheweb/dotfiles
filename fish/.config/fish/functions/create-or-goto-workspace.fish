function create-or-goto-workspace
    set dir $argv[1]

    if test -n "$dir"
        set session_name (basename $dir)
    else
        return 0
    end

    set workspaces (aerospace list-workspaces --all 2>/dev/null)

    if echo "$workspaces" | grep -x "$session_name" >/dev/null
        aerospace workspace "$session_name"

        set windows (aerospace list-windows --workspace $session_name)

        if test -z "$windows"
            open -na "Ghostty.app" $dir
        end
    else
        create-named-workspace $dir
    end

    return 0
end