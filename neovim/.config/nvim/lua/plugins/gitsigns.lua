return {
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

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- visual mode
      map('v', '<leader>ghs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[H]unk [S]tage' })
      map('v', '<leader>ghr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[H]unk [R]eset' })

      -- normal mode
      map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[H]unk [S]tage' })
      map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[H]unk [R]eset' })
      map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = '[H]unk [U]ndo Stage' })
      map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[H]unk [P]review' })
    end,
  },
}
