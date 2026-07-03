vim.pack.add { 'https://github.com/folke/which-key.nvim' }

require('which-key').setup {
  delay = 500,
  disable = {
    filetypes = { 'fugitive' },
  },
  icons = {
    breadcrumb = '',
    separator = ' ',
    group = '+',
    mappings = false,
  },
  triggers = {
    { '<auto>', mode = 'nxso' },
    { 'U', mode = 'n' },
    { 's', mode = 'nxso' },
  },
}

local wk = require 'which-key'
wk.add {
  { '<leader>f', desc = '+Find' },
  { '<leader>t', desc = '+Test' },
  { '<leader>g', desc = '+Git' },
  { '<leader>j', desc = '+Jump' },
  { 'U1', mode = { 'n', 'x' }, desc = '+Line' },
  { 'Uw', mode = { 'n', 'x' }, desc = '+Web' },
}
