-- Keybindings
local keymap = vim.api.nvim_set_keymap

keymap('i', 'jj', '<Esc>', {})

-- Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'ellisonleao/gruvbox.nvim'
end)

-- General Config
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.cmd [[colorscheme gruvbox]]

