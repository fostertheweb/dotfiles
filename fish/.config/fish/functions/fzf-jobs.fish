function fzf-jobs
    set jobs
    set dirs
    set menu
    set uniq_dirs
    set -A job2dir

    # Read jobs and directories
    set job_output (jobs -dl)
    set lines (string split \n $job_output)
    
    set i 1
    while test $i -le (count $lines)
        set jobline $lines[$i]
        if test (math $i + 1) -le (count $lines)
            set dirline $lines[(math $i + 1)]
            # Strip prefix and suffix
            set dirline (string replace -r '.*\(pwd[[:space:]]*:[[:space:]]' '' $dirline)
            set dirline (string replace -r '\)$' '' $dirline)
            
            set jobs $jobs $jobline
            set dirs $dirs $dirline
            set i (math $i + 2)
        else
            break
        end
    end

    if test (count $jobs) -eq 0
        echo "No background jobs to display."
        return 0
    end

    set len (count $jobs)

    # Build job to directory mapping
    for i in (seq 1 $len)
        set rid (string replace -r '^\[' '' $jobs[$i])
        set rid (string replace -r '\].*' '' $rid)
        set job2dir[$rid] $dirs[$i]
    end

    # Get unique directories
    for dir in $dirs
        if not contains $dir $uniq_dirs
            set uniq_dirs $uniq_dirs $dir
        end
    end

    # Build menu
    for dir in $uniq_dirs
        set display (string replace $HOME '~' $dir)
        set menu $menu (printf '\e[1;34m%s\e[0m' $display)
        for i in (seq 1 $len)
            if test $dirs[$i] = $dir
                set menu $menu "  $jobs[$i]"
            end
        end
    end

    set choice (printf '%s\n' $menu | fzf --ansi --no-sort); or return
    set stripped (printf '%s' $choice | sed -E 's/\x1b\[[0-9;]*m//g')

    if string match -q '  *' $stripped
        # job selected
        set jobline (string sub -s 3 $stripped)
        set rid (string replace -r '^\[' '' $jobline)
        set rid (string replace -r '\].*' '' $rid)
        set target $job2dir[$rid]
        # expand any leading ~
        set target (string replace '~' $HOME $target)
        cd $target; and fg "%$rid"
    else
        # dir selected
        set target (string replace '~' $HOME $stripped)
        cd $target
    end
end