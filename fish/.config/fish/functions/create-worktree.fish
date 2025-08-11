function create-worktree
    if test -z "$argv[1]"
        echo "Error: New worktree name required" >&2
        return 1
    end

    set trunk (git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
    set worktree (pwd | sed "s/"(basename (pwd))"/"(basename (pwd))"@$argv[1]/")
    git worktree add $worktree $trunk
    cd $worktree
    git status
end