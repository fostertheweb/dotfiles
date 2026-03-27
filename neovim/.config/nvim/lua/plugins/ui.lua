return {
  {
    'ahkohd/buffer-sticks.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>j',
        function()
          require('buffer-sticks').jump()
        end,
        desc = 'Jump to buffer',
      },
    },
    config = function()
      local sticks = require 'buffer-sticks'
      sticks.setup {
        transparent = true,
        filter = { buftypes = { 'terminal' } },
        highlights = {
          active = { link = 'Statement' },
          inactive = { link = 'Whitespace' },
          active_modified = { link = 'Constant' },
          inactive_modified = { link = 'Constant' },
          label = { link = 'Comment' },
        },
        preview = {
          enabled = false,
        },
      }
      sticks.show()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = {
            normal = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
            insert = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
            visual = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
            replace = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
            command = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
            inactive = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
          },
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          always_show_tabline = false,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'filename', 'diagnostics' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = { { 'branch', icon = '' }, 'diff' },
          lualine_z = { 'progress', 'location' },
        },
        inactive_sections = {},
      }
    end,
  },
  {
    'stevearc/quicker.nvim',
    config = function()
      require('quicker').setup {
        opts = {
          buflisted = false,
          number = false,
          relativenumber = false,
          signcolumn = 'auto',
          winfixheight = true,
          wrap = false,
        },
        borders = {
          vert = '|',
        },
        keys = {
          { '<C-j>', '<CR>', desc = 'Ctrl-j to accept' },
          {
            '>',
            function()
              require('quicker').expand {
                before = 2,
                after = 2,
                add_to_existing = true,
              }
            end,
            desc = 'Expand quickfix context',
          },
          {
            '<',
            function()
              require('quicker').collapse()
            end,
            desc = 'Collapse quickfix context',
          },
        },
        trim_leading_whitespace = 'all',
      }

      vim.keymap.set('n', '<leader>q', function()
        require('quicker').toggle()
      end, {
        desc = 'Toggle quickfix',
      })
      vim.keymap.set('n', '<leader>l', function()
        require('quicker').toggle { loclist = true }
      end, {
        desc = 'Toggle loclist',
      })
    end,
  },
}
