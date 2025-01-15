return {
  'leath-dub/snipe.nvim',
  config = function()
    require('snipe').setup {
      ui = {
        open_win_override = {
          title = 'Buffers',
          border = 'single',
        },
      },
    }

    vim.keymap.set('n', 'gj', function()
      require('snipe').open_buffer_menu()
    end, { desc = 'Go jump to buffer' })
  end,
}
