function origin-status
    if test -n "$argv[1]"
        z $argv[1]
    end

    git fetch origin

    set trunk (git remote show origin | grep 'HEAD branch' | awk '{print $NF}')
    set counts (git rev-list --left-right --count HEAD...origin/$trunk)
    set behind (echo $counts | awk '{print $1}')
    set ahead (echo $counts | awk '{print $2}')
    set output "$behind behind, $ahead ahead"
    set merge_dry_run (git merge --no-commit --no-ff --dry-run origin/main 2>&1)

    if echo "$merge_dry_run" | grep -q 'CONFLICT'
        set output "$output with conflicts"
    end

    echo $output
end