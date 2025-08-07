return {
  {
    'neovim/nvim-lspconfig',
    cond = not vim.g.vscode,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    config = function()
      require('ts-error-translator').setup()
    end,
  },
}
