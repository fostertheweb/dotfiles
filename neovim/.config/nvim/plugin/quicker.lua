vim.pack.add { 'https://github.com/stevearc/quicker.nvim' }

require('quicker').setup {
  opts = {
    buflisted = false,
    number = false,
    relativenumber = false,
    signcolumn = 'auto',
    winfixheight = true,
    wrap = false,
  },
  borders = {
    vert = '|',
  },
  keys = {
    { '<C-j>', '<CR>', desc = 'Ctrl-j to accept' },
    {
      '>',
      function()
        require('quicker').expand {
          before = 2,
          after = 2,
          add_to_existing = true,
        }
      end,
      desc = 'Expand quickfix context',
    },
    {
      '<',
      function()
        require('quicker').collapse()
      end,
      desc = 'Collapse quickfix context',
    },
  },
  trim_leading_whitespace = 'all',
}

vim.keymap.set('n', '<leader>q', function()
  require('quicker').toggle()
end, {
  desc = 'Toggle quickfix',
})
vim.keymap.set('n', '<leader>l', function()
  require('quicker').toggle { loclist = true }
end, {
  desc = 'Toggle loclist',
})
