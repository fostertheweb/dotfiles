#!/usr/bin/env fish

# Fish doesn't use bindkey like zsh, it uses fish_user_key_bindings
# Create a function for key bindings
function fish_user_key_bindings
    # ctrl-z
    # Bring bg process to the fg
    bind \cz 'fg 2>/dev/null; commandline -f repaint'
    
    # ctrl-t
    # List current sessions and attach
    bind \ct 'tmux-list-and-attach; commandline -f repaint'
    
    # cmd-o (Alt+o in fish)
    # Find project and create or attach
    bind \eo 'tmux-find-and-create-or-attach; commandline -f repaint'
    
    # cmd-f (Alt+f in fish)
    # Find file with fzf
    bind \ef 'find-file; commandline -f repaint'
    
    # cmd-e (Alt+e in fish)
    # Open cwd in nvim
    bind \ee 'nvim -c "ProjectFiles"; commandline -f repaint'
    
    # cmd-/ (Alt+/ in fish)
    # Open ranger file manager
    bind \e/ 'ranger; commandline -f repaint'
    
    # cmd-s (Alt+s in fish)
    # Create tmux session
    bind \es 'tmux-create-cwd-session; commandline -f repaint'
    
    # cmd-d (Alt+d in fish)
    # Go to dotfiles
    bind \ed 'cd $HOME/.dotfiles; commandline -f repaint'
    
    # cmd-g (Alt+g in fish)
    # Grep in cwd
    bind \eg 'grep-cwd; commandline -f repaint'
    
    # cmd-shift-p (Alt+P in fish)
    # Run fish function
    bind \eP 'run-zsh-fn; commandline -f repaint'
    
    # cmd-r (Alt+r in fish)
    # Source fish config
    bind \er 'source $HOME/.config/fish/config.fish; commandline -f repaint'
    
    # cmd-y (Alt+y in fish)
    # Run GUI application
    bind \ey 'run-app; commandline -f repaint'
end
