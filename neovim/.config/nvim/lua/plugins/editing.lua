return {
  {
    'windwp/nvim-autopairs',
    enabled = true,
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
