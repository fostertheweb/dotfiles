return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                url = 'http://127.0.0.1:1234',
              },
              schema = {
                model = {
                  default = 'qwen2.5-7b-instruct-1m',
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = 'ollama',
          },
          inline = {
            adapter = 'ollama',
          },
        },
      }

      -- Keymaps
      vim.keymap.set('n', '<leader>cc', '<CMD>CodeCompanionChat Toggle<CR>', { desc = 'Chat' })
      vim.keymap.set('n', '<leader>cl', '<CMD>CodeCompanion<CR>', { desc = 'Inline Prompt' })
      vim.keymap.set('n', '<leader>c.', '<CMD>codecompanionActions<CR>', { desc = 'Actions' })
    end,
  },
}
