return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  config = function()
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
      },
      trim_leading_whitespace = true,
    }
  end,
}
