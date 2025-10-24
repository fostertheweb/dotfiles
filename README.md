# fostertheweb's dotfiles

<img width="1512" height="982" alt="Screenshot 2025-10-18 at 01 18 30" src="https://github.com/user-attachments/assets/72b53a3d-2c8d-4f44-b630-72aa56d41d27" />


## Setup

```bash
git clone git@github.com:fostertheweb/dotfiles.git ~/.dotfiles
```

```bash
cd ~/.dotfiles
```

## Install Script

```bash
./install

```

### Requirements

- [Bun](https://bun.sh) - Install via Homebrew: `brew install oven-sh/bun/bun`
- [Stow](https://www.gnu.org/software/stow/) - Install via Homebrew: `brew install stow`

### Features

- 🔍 **Smart Configuration Detection** - Automatically discovers available configuration packages
- 📊 **Status Display** - Shows which configurations are currently linked
- ⚡ **Interactive Setup** - Prompts for each setup step with clear feedback
- 🎨 **Enhanced UI** - Colored output with spinners and status indicators
- 🔗 **Symlink Validation** - Checks existing symlink status before operations
