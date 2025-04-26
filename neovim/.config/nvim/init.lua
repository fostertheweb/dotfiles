require 'autocmds'
require 'options'
require 'lsp'
require 'keymaps'
require 'usercmds'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'themes' },
  { import = 'plugins' },
}

-- Default theme settings
vim.o.background = 'dark'
vim.cmd 'colorscheme farout'
vim.opt.termguicolors = true
vim.cmd.hi 'Comment gui=none'

if require('utils').is_dark_mode() then
  vim.cmd 'colorscheme farout'
else
  vim.cmd 'colorscheme sonokai'
end

-- vim: ts=2 sts=2 sw=2 et
