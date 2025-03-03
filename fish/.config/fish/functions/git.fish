#!/usr/bin/env fish

function create-worktree
    if test -z "$argv[1]"
        echo "Error: New worktree name required" >&2
        return 1
    end

    set trunk (git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
    set worktree (pwd | sed "s/$(basename (pwd))/$(basename (pwd))@$argv[1]/")
    git worktree add $worktree $trunk
    cd $worktree
    git status
end

function select-git-branch
    set fzf_cmd "fzf --keep-right --border-label \" Checkout Branch \" --prompt \" : \""
    git branch -v | eval $fzf_cmd | sed -E 's/^[* ]+([a-zA-Z0-9_-]+).*/\1/' | xargs git checkout
end

function origin-status
    git fetch origin

    set trunk (git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
    set counts (git rev-list --left-right --count HEAD...origin/$trunk)
    set behind (echo $counts | awk '{print $1}')
    set ahead (echo $counts | awk '{print $2}')
    set output "$behind behind, $ahead ahead"
    set merge_dry_run (git merge --no-commit --no-ff --dry-run origin/main 2>&1)

    if string match -q "*CONFLICT*" "$merge_dry_run"
        set output "$output with conflicts"
    end

    echo $output
end
