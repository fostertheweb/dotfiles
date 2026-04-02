vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
  'https://github.com/windwp/nvim-ts-autotag',
}

require('nvim-treesitter.config').setup {
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
}

require('nvim-treesitter-textobjects').setup {}

require('treesitter-context').setup {
  max_lines = 3,
  trim_scope = 'inner',
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

require('nvim-ts-autotag').setup()
