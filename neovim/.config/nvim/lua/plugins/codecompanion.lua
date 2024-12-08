return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = {
        'markdown',
        'codecompanion',
      },
    },
  },
  enabled = false,
  config = function()
    require('codecompanion').setup {
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            env = {
              api_key = 'cmd:op read op://Private/OpenAI/credential --no-newline',
            },
          })
        end,
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            env = {
              url = 'http://127.0.0.1:11434',
            },
            headers = {
              ['Content-Type'] = 'application/json',
            },
            parameters = {
              sync = true,
            },
            schema = {
              model = {
                default = 'deepseek-coder-v2:latest',
              },
            },
          })
        end,
      },
      display = {
        chat = {
          render_headers = true,
        },
      },
      strategies = {
        chat = {
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
      },
    }
  end,
}
