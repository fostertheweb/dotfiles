return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    cond = not vim.g.vscode,
    opts = {
      anti_conceal = { enabled = false },
      file_types = { 'markdown', 'opencode_output' },
    },
    ft = { 'markdown', 'opencode_output' },
  },
  {
    'folke/todo-comments.nvim',
    cond = not vim.g.vscode,
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
