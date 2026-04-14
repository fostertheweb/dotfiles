vim.pack.add {
  'https://github.com/stevearc/oil.nvim',
}

require('oil').setup {
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ['<C-j>'] = 'actions.select',
    ['<Esc>'] = 'actions.close',
  },
}

vim.keymap.set('n', '-', function()
  require('oil').open_float()
  vim.wait(1000, function()
    return require('oil').get_cursor_entry() ~= nil
  end)
  if require('oil').get_cursor_entry() then
    require('oil').open_preview()
  end
end, { desc = 'Open directory' })
