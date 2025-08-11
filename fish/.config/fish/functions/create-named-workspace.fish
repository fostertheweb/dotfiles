function create-named-workspace
    if test -z "$argv[1]"
        return 0
    end

    set dir $argv[1]

    aerospace workspace (basename $dir)
    open -na "Ghostty.app" $dir
end