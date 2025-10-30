vim.env.GIT_EXTERNAL_DIFF = nil
vim.opt.diffexpr = ''

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
vim.opt.termguicolors = true
vim.cmd 'colorscheme kanagawa'
vim.cmd.hi 'Comment gui=none'

vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NavicText', { bg = 'NONE', fg = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg })
vim.api.nvim_set_hl(0, 'NavicSeparator', { bg = 'NONE', fg = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg })

-- vim: ts=2 sts=2 sw=2 et
