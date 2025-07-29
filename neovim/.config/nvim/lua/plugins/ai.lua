return {
  {
    'NickvanDyke/opencode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    opts = {
      provider_id = 'github-copilot',
      model_id = 'claude-sonnet-4',
    },
    keys = {
      {
        '<leader>i',
        function()
          require('opencode').toggle()
        end,
        desc = 'Toggle chat',
      },
      {
        '<leader>ca',
        function()
          require('opencode').ask()
        end,
        desc = 'Ask opencode',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cn',
        function()
          require('opencode').create_session()
        end,
        desc = 'New session',
      },
      {
        '<leader>ce',
        function()
          require('opencode').prompt 'Explain @cursor and its context'
        end,
        desc = 'Explain',
      },
      {
        '<leader>cr',
        function()
          require('opencode').prompt 'Review @file for correctness and readability'
        end,
        desc = 'Review',
      },
      {
        '<leader>cf',
        function()
          require('opencode').prompt 'Fix these @diagnostics'
        end,
        desc = 'Fix',
      },
      {
        '<leader>co',
        function()
          require('opencode').prompt 'Optimize @selection for performance and readability'
        end,
        desc = 'Optimize',
        mode = 'v',
      },
      {
        '<leader>cd',
        function()
          require('opencode').prompt 'Add documentation comments for @selection'
        end,
        desc = 'Document',
        mode = 'v',
      },
      {
        '<leader>ct',
        function()
          require('opencode').prompt 'Add tests for @selection'
        end,
        desc = 'Tests',
        mode = 'v',
      },
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    enabled = true,
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
