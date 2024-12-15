return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('snacks').setup {
      gitbrowse = { enabled = true },
    }

    vim.keymap.set('n', '<leader>gw', function()
      local branch = vim.fn.system 'git branch --show-current 2>/dev/null'
      local line_number = vim.api.nvim_win_get_cursor(0)[1]
      Snacks.gitbrowse.open {
        what = 'file',
        branch = branch:match '^%s*(.-)%s*$',
        line_count = line_number,
      }
    end, { desc = 'Open GitHub web' })
  end,
}
