return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'copilot-chat' },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        config = function()
          require('copilot').setup {
            suggestion = {
              enabled = false,
            },
          }
        end,
      },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      chat_autocomplete = false,
      mappings = {
        submit_prompt = {
          insert = '<C-j>',
        },
      },
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
