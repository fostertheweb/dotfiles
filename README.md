## 🤓 my dotfiles

### Setup

```bash
$ git clone git@github.com:fostertheweb/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow fish neovim git
```

### Install [vim-plug](https://github.com/junegunn/vim-plug)

```bash
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
$ nvim +PlugInstall +qa
```
