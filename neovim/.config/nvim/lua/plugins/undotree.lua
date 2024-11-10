return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<leader>u', '<CMD>UndotreeToggle<CR>', { desc = '[U]ndo Tree' })
  end,
}
