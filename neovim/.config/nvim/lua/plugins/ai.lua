return {
  {
    'ThePrimeagen/99',
    config = function()
      local _99 = require '99'

      _99.setup {
        tmp_dir = './tmp',
        completion = {
          files = {
            enabled = true,
            max_file_size = 102400,
            max_files = 5000,
            exclude = { '.env', '.env.*', 'node_modules', '.git' },
          },
          source = 'native',
        },
        md_files = {
          'AGENT.md',
        },
      }

      vim.keymap.set('v', '<leader>9v', function()
        _99.visual()
      end)

      vim.keymap.set('n', '<leader>9x', function()
        _99.stop_all_requests()
      end)

      vim.keymap.set('n', '<leader>9s', function()
        _99.search()
      end)
    end,
  },
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
    'piersolenski/wtf.nvim',
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
