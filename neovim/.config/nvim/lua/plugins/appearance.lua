return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      anti_conceal = { enabled = false },
      completions = { lsp = { enabled = true } },
      file_types = { 'markdown' },
    },
    ft = { 'markdown' },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
