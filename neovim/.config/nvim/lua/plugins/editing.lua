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
    config = true,
    keys = {
      { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
