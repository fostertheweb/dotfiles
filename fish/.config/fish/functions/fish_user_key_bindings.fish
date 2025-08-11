function fish_user_key_bindings
    # ctrl-z - Bring bg process to the fg
    bind \cz 'fg; commandline -f repaint'

    # ctrl-o - Jump to last directory
    bind \co 'cd -; commandline -f repaint'

    # ctrl-g - open gitu
    bind \cg 'gitu; commandline -f repaint'

    # cmd-f - Find file with fzf (alt-f as cmd may not be available)
    bind \ef 'find-file; commandline -f repaint'

    # cmd-e - Open cwd in nvim (alt-e)
    bind \ee 'nvim -c "ProjectFiles"; commandline -f repaint'

    # cmd-- - Open walk to navigate files (alt--)
    bind \e- 'walk; commandline -f repaint'

    # cmd-d - Go to dotfiles (alt-d)
    bind \ed 'cd $HOME/.dotfiles; commandline -f repaint'

    # cmd-i - launch opencode (alt-i)
    bind \ei 'opencode; commandline -f repaint'

    # cmd-/ - Grep in cwd (alt-/)
    bind \e/ 'grep-cwd; commandline -f repaint'

    # cmd-r - Source fish config (alt-r)
    bind \er 'source $HOME/.config/fish/config.fish; commandline -f repaint'

    # cmd-y - Run GUI application (alt-y)
    bind \ey 'run-app; commandline -f repaint'

    # cmd-u - Git pull (alt-u)
    bind \eu 'git pull; commandline -f repaint'

    # TODO: ctrl-t - List workspaces and goto or create
    bind \ct 'list-workspaces-and-goto-or-create; commandline -f repaint'

    # TODO: cmd-o - Find project and create or goto workspace
    bind \eo 'find-and-create-or-goto-workspace; commandline -f repaint'

    # cmd-s - Create workspace
    bind \es 'create-named-workspace (pwd); commandline -f repaint'
end
