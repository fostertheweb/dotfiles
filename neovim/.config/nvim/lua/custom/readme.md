# Neovim Undo History

A Neovim plugin that displays the undo history of the current file in a floating window, allowing you to navigate through changes, view diffs, revert to specific revisions, or copy content from previous states.

## Features

- View complete undo history in a floating window
- Navigate through undo tree with keyboard shortcuts
- Preview changes with side-by-side diff view
- Revert to any point in history with a single keypress
- Copy content from any historical state
- Customizable UI and keybindings

## Installation

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'username/nvim-undo-history',
  requires = {},
  config = function()
    require('undo-history').setup()
  end
}
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'username/nvim-undo-history',
  dependencies = {},
  config = function()
    require('undo-history').setup()
  end
}
```

## Usage

The plugin provides the command `:UndoHistory` to open the undo history window.

You can also map this command to a key in your configuration:

```lua
vim.keymap.set('n', '<leader>u', ':UndoHistory<CR>', { noremap = true, silent = true })
```

### Default keybindings

Once the undo history window is open:

- `j`: Navigate to the next (newer) change
- `k`: Navigate to the previous (older) change
- `r`: Revert to the selected change
- `y`: Copy content from the selected change
- `q`: Close the window

## Configuration

You can customize the plugin by passing options to the setup function:

```lua
require('undo-history').setup({
  window = {
    width = 80,       -- Width of the history window
    height = 20,      -- Height of the history window
    border = "rounded", -- Border style ("none", "single", "double", "rounded", etc.)
  },
  mappings = {
    next = "j",      -- Navigate to next entry
    prev = "k",      -- Navigate to previous entry
    revert = "r",    -- Revert to selected entry
    copy = "y",      -- Copy content from selected entry
    close = "q",     -- Close window
  },
  diff_opts = {
    internal = true,  -- Use internal diff
    vertical = false, -- Horizontal diff layout
  }
})
```

## API

The plugin provides the following functions that you can call from your Lua code:

- `require('undo-history').open()` - Open the undo history window
- `require('undo-history').close()` - Close the undo history window
- `require('undo-history').setup(opts)` - Configure the plugin

## License

MIT
