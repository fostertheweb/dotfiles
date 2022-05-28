-- Keybindings
local keymap = vim.api.nvim_set_keymap

keymap('i', 'jj', '<Esc>', {})
keymap('n', '<C-p>', ':Telescope git_files<CR>', {})

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'savq/melange'
  use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }
  use 'editorconfig/editorconfig-vim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup {
        options = {
          theme = 'powerline'
        }
      }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function ()
      local telescope = require('telescope')
      telescope.setup()
      telescope.load_extension('fzf')
    end
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "bash",
          "c",
          "lua",
          "rust",
          "c_sharp",
          "dockerfile",
          "fish",
          "go",
          "javascript",
          "typescript",
          "tsx",
        },
        hightlight = {
          enabled = true,
        },
        indent = {
          enable = true,
        }
      })
    end
  }
  use {
    'williamboman/nvim-lsp-installer',
    {
      'neovim/nvim-lspconfig',
      config = function ()
      	require('nvim-lsp-installer').setup({
          automatic_installation = true,
      	})
      end
    }
  }
end)

-- Options
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.cmd [[colorscheme melange]]

