require 'autocmds'
require 'options'
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
  { import = 'themes.kanagawa' },
  { import = 'themes.chalktone' },
  { import = 'plugins' },
}

-- Default theme settings
vim.o.background = 'dark'
vim.cmd 'colorscheme kanagawa-dragon'
vim.opt.termguicolors = true
vim.cmd.hi 'Comment gui=none'

if require('utils').is_dark_mode() then
  vim.cmd 'colorscheme kanagawa-dragon'
else
  vim.cmd 'colorscheme chalktone'
end

-- vim: ts=2 sts=2 sw=2 et
