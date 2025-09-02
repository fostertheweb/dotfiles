# fostertheweb's dotfiles

<img width="1512" height="982" alt="Screenshot 2025-08-14 at 17 03 53" src="https://github.com/user-attachments/assets/8f9258ad-1efc-43a1-94d7-ccfda35bec2d" />

## Setup

```bash
git clone git@github.com:fostertheweb/dotfiles.git ~/.dotfiles
```

```bash
cd ~/.dotfiles
```

```bash
./install.js
```

### Requirements

- [Bun](https://bun.sh) - Install via Homebrew: `brew install bun`
- [Stow](https://www.gnu.org/software/stow/) - Install via Homebrew: `brew install stow`

### Features

- 🔍 **Smart Configuration Detection** - Automatically discovers available configuration packages
- 📊 **Status Display** - Shows which configurations are currently linked
- ⚡ **Interactive Setup** - Prompts for each setup step with clear feedback
- 🎨 **Enhanced UI** - Colored output with spinners and status indicators
- 🔗 **Symlink Validation** - Checks existing symlink status before operations
