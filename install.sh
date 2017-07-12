#!/bin/bash

# Install Vim Plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

# Source zsh config
source ~/.zshrc

# Install latest version of Node
nvm install node
nvm alias default node

# put configs into place
ln -s ~/.vim/nvimrc ~/.config/nvim/init.vim
cp tmux.conf ~/.tmux.conf

# create gopath
mkdir -p ~/Source/go/src/github.com/fostertheweb

# install vim plugins
nvim +PlugInstall +qall

