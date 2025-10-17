return {
  { 'akinsho/git-conflict.nvim', version = '*', config = true },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>gK', function()
          gitsigns.reset_hunk()
        end, { desc = 'Discard hunk' })

        map('n', '<leader>gs', function()
          gitsigns.stage_hunk()
        end, { desc = 'Stage hunk' })

        map('n', '<leader>gq', function()
          gitsigns.setqflist 'all'
        end, { desc = 'Quickfix  hunks' })

        -- Next change
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next change' })

        -- Previous change
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Previous change' })
      end,
    },
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup {}
      vim.treesitter.language.register('markdown', 'octo')
      vim.keymap.set('n', '<leader>gr', '<CMD>Octo pr list<CR>', { desc = 'Pull Requests' })
    end,
  },
  {
    'axkirillov/unified.nvim',
    config = function()
      require('unified').setup()

      vim.keymap.set('n', '<leader>rr', function()
        local dog = require('unified.command').run 'origin/HEAD'
        vim.notify(dog)
      end, { desc = 'Pull Requests' })
    end,
  },
}
