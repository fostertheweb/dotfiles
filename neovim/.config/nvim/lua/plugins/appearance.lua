return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    cond = not vim.g.vscode,
    ft = { 'markdown' },
  },
  {
    'folke/todo-comments.nvim',
    cond = not vim.g.vscode,
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
