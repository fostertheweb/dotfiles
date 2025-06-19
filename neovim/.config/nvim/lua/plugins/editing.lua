return {
  {
    'windwp/nvim-ts-autotag',
    cond = not vim.g.vscode,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'tpope/vim-sleuth',
    cond = not vim.g.vscode,
  },
}
