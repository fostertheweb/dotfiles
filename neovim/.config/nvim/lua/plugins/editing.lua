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
}
