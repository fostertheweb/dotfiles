return {
  {
    'numToStr/Comment.nvim',
    enabled = false,
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    enabled = false,
    event = 'InsertEnter',
    config = true,
  },
  {
    'windwp/nvim-ts-autotag',
    config = true,
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'tpope/vim-sleuth',
  },
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('undotree').setup()
      vim.keymap.set('n', '<leader>u', "<CMD>lua require('undotree').toggle()<Cr>", { desc = 'Undo history' })
    end,
  },
}
