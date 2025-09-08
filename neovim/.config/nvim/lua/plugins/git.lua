return {
  {
    'sindrets/diffview.nvim',
    config = function()
      require('diffview').setup {
        view = {
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = 'diff2_horizontal',
            disable_diagnostics = false, -- Temporarily disable diagnostics for diff buffers while in the view.
            winbar_info = false, -- See |diffview-config-view.x.winbar_info|
          },
          merge_tool = {
            layout = 'diff1_plain',
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = 'diff2_horizontal',
            disable_diagnostics = false,
            winbar_info = false,
          },
        },
      }

      vim.keymap.set('n', '<leader>gd', '<CMD>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>', { desc = 'Diff' })
      vim.keymap.set('n', '<leader>gm', '<CMD>DiffviewOpen<CR>', { desc = 'Merge' })
      vim.keymap.set('n', '<leader>gf', '<CMD>DiffviewFileHistory %<CR>', { desc = 'File history' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
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
      require('octo').setup {
        picker = 'snacks',
      }
      vim.treesitter.language.register('markdown', 'octo')
      vim.keymap.set('n', '<leader>gr', '<CMD>Octo pr list<CR>', { desc = 'Pull Requests' })
    end,
  },
}
