-- Keybindings
local keymap = vim.api.nvim_set_keymap

keymap('i', 'jj', '<Esc>', {})

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'savq/melange'
  use 'editorconfig/editorconfig-vim'
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

vim.cmd [[colorscheme melange]]

