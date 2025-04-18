return {
  {
    'windwp/nvim-autopairs',
    enabled = false,
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      enable_check_bracket_line = true,
      fast_wrap = false,
      ignored_next_char = '[%w%.]',
    },
  },
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
