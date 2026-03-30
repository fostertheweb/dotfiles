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
  -- 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  -- 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
}
-- require('nvim-treesitter.configs').setup {
--   auto_install = true,
--   highlight = { enable = true },
--   indent = { enable = true },
-- }

require('treesitter-context').setup {
  max_lines = 3,
  trim_scope = 'inner',
}

-- require('ts_context_commentstring').setup {}

-- vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
--   callback = function()
--     vim.pack.add 'https://github.com/windwp/nvim-ts-autotag'
--     require('nvim-ts-autotag').setup()
--   end,
-- })
