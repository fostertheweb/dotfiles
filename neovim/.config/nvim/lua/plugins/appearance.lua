return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      anti_conceal = { enabled = false },
      completions = { lsp = { enabled = true } },
      file_types = { 'markdown', 'Avante' },
    },
    ft = { 'markdown', 'Avante' },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
