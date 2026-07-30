vim.pack.add { 'https://github.com/error311/wayfinder.nvim' }

require('wayfinder').setup {
  layout = {
    width = 0.9,
    height = 0.85,
    show_hints = false,
  },
}

vim.keymap.set('n', '<leader>x', '<CMD>Wayfinder<CR>', {
  desc = 'Explore',
})
