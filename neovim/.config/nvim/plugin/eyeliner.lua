vim.pack.add {'https://github.com/jinh0/eyeliner.nvim' }

require('eyeliner').setup {
  highlight_on_key = true,
  dim = true,
  disabled_filetypes = {},
  disabled_buftypes = {},
  default_keymaps = true,
}

vim.api.nvim_set_hl(0, 'EyelinerPrimary', {
  fg = '#ff007c',
  bold = true,
  ctermfg = 198,
  cterm = { bold = true, underline = true },
})

vim.api.nvim_set_hl(0, 'EyelinerSecondary', {
  fg = '#00dfff',
  bold = true,
  ctermfg = 45,
  cterm = { bold = true, underline = true },
})
