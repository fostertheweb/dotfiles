return {
  {
    'sudo-tee/opencode.nvim',
    cond = not vim.g.vscode,
    config = function()
      require('opencode').setup {}
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    cond = not vim.g.vscode,
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    config = function()
      require('supermaven-nvim').setup {
        ignore_filetypes = { 'copilot-chat' },
        keymaps = {
          accept_suggestion = '<C-f>',
          clear_suggestion = '<C-k>',
          accept_word = '<C-l>',
        },
      }
    end,
  },
}
