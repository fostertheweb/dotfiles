return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  build = ':TSUpdate',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    }

    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }
  end,
}
