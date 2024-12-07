return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      default_file_explorer = true,
      delete_to_trash = true,
      keymaps = {
        ['<C-j>'] = 'actions.select',
      },
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>o', '<CMD>Oil --float<CR>', { desc = '[O]pen parent directory' })
  end,
}
