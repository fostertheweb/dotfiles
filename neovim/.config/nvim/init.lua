require 'options'
require 'keymaps'
require 'misc'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  { import = 'themes.black-metal' },
  { import = 'themes.zenbones' },
  { import = 'plugins' },
}

-- Default theme settings
vim.o.background = 'dark'
vim.cmd 'colorscheme base16-black-metal-bathory'
vim.opt.termguicolors = true
vim.cmd.hi 'Comment gui=none'

if require('utils').is_dark_mode() then
  vim.cmd 'colorscheme base16-black-metal-bathory'
else
  vim.o.background = 'light'
  vim.cmd 'colorscheme zenbones'
end

require('custom.undotree').setup {
  window = {
    width = 80,
    height = 20,
    border = 'rounded',
  },
  mappings = {
    next = 'j',
    prev = 'k',
    revert = 'r',
    copy = 'y',
    close = 'q',
  },
  diff_opts = {
    internal = true,
    vertical = false,
  },
}

-- vim: ts=2 sts=2 sw=2 et
