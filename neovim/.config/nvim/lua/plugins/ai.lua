local utils = require 'utils'
local default_agent = utils.is_work_computer() and 'claude' or 'copilot'

return {
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    dependencies = { 'AndreM222/copilot-lualine' },
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<C-f>',
            accept_word = '<C-l>',
            accept_line = '<C-e>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      }
    end,
  },
  {
    'folke/sidekick.nvim',
    opts = {
      cli = {
        picker = 'snacks',
        tools = {
          amp = { cmd = { 'amp' }, url = 'https://ampcode.com/' },
        },
      },
      nes = {
        enabled = false,
      },
    },
    keys = {
      {
        '<C-.>',
        function()
          require('sidekick.cli').toggle {
            name = default_agent,
            focus = true,
          }
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send {
            name = default_agent,
            msg = '{this}',
          }
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send {
            name = default_agent,
            msg = '{file}',
          }
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send {
            name = default_agent,
            msg = '{selection}',
          }
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt {
            name = default_agent,
          }
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
    },
  },
  {
    'piersolenski/wtf.nvim',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
    },
    opts = {
      provider = 'copilot',
    },
  },
}
