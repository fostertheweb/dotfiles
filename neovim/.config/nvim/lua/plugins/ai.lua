return {
  {
    'piersolenski/wtf.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {},
    keys = {
      {
        '<leader>dh',
        mode = { 'n', 'x' },
        function()
          require('wtf').ai()
        end,
        desc = 'Help',
      },
      {
        mode = { 'n' },
        '<leader>df',
        function()
          require('wtf').search()
        end,
        desc = 'Search diagnostic with Google',
      },
    },
  },
}
