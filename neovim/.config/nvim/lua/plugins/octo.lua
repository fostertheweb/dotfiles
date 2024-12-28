return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup()
    vim.treesitter.language.register('markdown', 'octo')
    vim.keymap.set('n', '<leader>grf', '<CMD>Octo pr list<CR>', { desc = 'Find' })
  end,
}
