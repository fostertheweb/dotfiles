function list-workspaces-and-goto-or-create
    set workspaces (aerospace list-workspaces --all | grep -vE '^[[:space:]]*[0-9]+[[:space:]]*$')
    set fzf_cmd "fzf --header '  Workspaces'"
    set current_workspace (aerospace list-workspaces --focused)

    if test -z "$workspaces"
        create-named-workspace (select-git-project)
    else
        set workspace_count (echo "$workspaces" | wc -l | string trim)
        if test $workspace_count -eq 1
            # check if the only workspace is the current one
            create-or-goto-workspace (select-git-project)
        else
            set chosen_workspace (echo $workspaces | eval $fzf_cmd)

            if test -z "$chosen_workspace"
                return 0
            end

            aerospace workspace $chosen_workspace
        end
    end
end