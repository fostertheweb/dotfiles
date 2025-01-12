require 'options'
require 'keymaps'
require 'misc'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'themes.kanagawa' },
  { import = 'plugins' },
}

local utils = require 'utils'

if utils.is_dark_mode() then
  vim.o.background = 'dark'
else
  vim.o.background = 'light'
end

-- vim: ts=2 sts=2 sw=2 et
