return {
  { 'akinsho/git-conflict.nvim', config = true },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    },
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {
        picker = 'snacks',
      }
      vim.treesitter.language.register('markdown', 'octo')
      vim.keymap.set('n', '<leader>gr', '<CMD>Octo pr list<CR>', { desc = 'Pull Requests' })
    end,
  },
}
