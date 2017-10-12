Dotfiles
========

Forked from [alexpearce/dotfiles](https://github.com/alexpearce/dotfiles)

Usage
-----

Pull the repository, and then create the symbolic links [using GNU
stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).

```bash
$ git clone git@github.com:fostertheweb/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish neovim tmux git # plus whatever else you'd like
```

The Vim dotfiles depend on [vim-plug](https://github.com/junegunn/vim-plug) for 
installing Vim plugins:

```bash
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ nvim +PlugInstall +qa
```

License
-------

[MIT](http://opensource.org/licenses/MIT)