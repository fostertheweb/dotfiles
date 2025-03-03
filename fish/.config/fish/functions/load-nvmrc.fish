#!/usr/bin/env fish

function load-nvmrc
    set nvmrc_path (nvm_find_nvmrc)

    if test -n "$nvmrc_path"
        set nvmrc_node_version (nvm version (cat "$nvmrc_path"))

        if test "$nvmrc_node_version" = "N/A"
            nvm install
        else if test "$nvmrc_node_version" != (nvm version)
            nvm use
        end
    else if test -n (cd $OLDPWD; nvm_find_nvmrc) && test (nvm version) != (nvm version default)
        echo "Reverting to nvm default version"
        nvm use default
    end
end
