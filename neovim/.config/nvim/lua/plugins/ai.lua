return {
  {
    'GeorgesAlkhouri/nvim-aider',
    cmd = 'Aider',
    keys = {
      { '<leader>a/', '<cmd>Aider toggle<cr>', desc = 'Toggle' },
      { '<leader>as', '<cmd>Aider send<cr>', desc = 'Send to context', mode = { 'n', 'v' } },
      { '<leader>ac', '<cmd>Aider command<cr>', desc = 'Commands' },
      { '<leader>ab', '<cmd>Aider buffer<cr>', desc = 'Send buffer' },
      { '<leader>a+', '<cmd>Aider add<cr>', desc = 'Add file' },
      { '<leader>a-', '<cmd>Aider drop<cr>', desc = 'Drop file' },
      { '<leader>ar', '<cmd>Aider add readonly<cr>', desc = 'Add read-only' },
    },
    dependencies = {
      'folke/snacks.nvim',
    },
    config = true,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    cond = not vim.g.vscode,
    ft = { 'markdown', 'copilot-chat' },
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
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = false,
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        config = function()
          require('copilot').setup {
            suggestion = {
              enabled = false,
              auto_trigger = true,
              keymap = {
                accept = '<C-f>',
                accept_word = '<C-l>',
                accept_line = false,
                next = '<M-]>',
                prev = '<M-[>',
                dismiss = '<C-e>',
              },
            },
          }
        end,
      },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      chat_autocomplete = true,
      mappings = {
        submit_prompt = {
          insert = '<C-j>',
        },
      },
      model = 'copilot:claude-3.7-sonnet-thought',
    },
    config = function(_, opts)
      require('CopilotChat').setup(opts)

      vim.keymap.set('n', '<leader>co', '<CMD>CopilotChatToggle<CR>', { desc = 'Chat' })
      vim.keymap.set('n', '<leader>ce', '<CMD>CopilotChatExplain<CR>', { desc = 'Explain' })
      vim.keymap.set('n', '<leader>cf', '<CMD>CopilotChatFix<CR>', { desc = 'Fix' })
      vim.keymap.set('n', '<leader>cc', '<CMD>CopilotChatCommit<CR>', { desc = 'Commit' })
    end,
  },
}
