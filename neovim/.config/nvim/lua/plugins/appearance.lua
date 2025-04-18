return {
  {
    'mvllow/modes.nvim',
    enabled = false,
    config = function()
      require('modes').setup()
    end,
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    cond = not vim.g.vscode,
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
        trim_leading_whitespace = 'all',
      }
    end,
  },
  {
    'folke/todo-comments.nvim',
    cond = not vim.g.vscode,
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
