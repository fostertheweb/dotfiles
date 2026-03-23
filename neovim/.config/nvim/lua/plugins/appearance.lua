return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      anti_conceal = { enabled = false },
      completions = { lsp = { enabled = true } },
      file_types = { 'markdown' },
      only_render_image_at_cursor = true,
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
