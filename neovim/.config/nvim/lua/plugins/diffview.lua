return {
  'sindrets/diffview.nvim',
  config = function()
    vim.keymap.set('n', '<leader>grd', '<CMD>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>', { desc = 'Diff' })
  end,
}
