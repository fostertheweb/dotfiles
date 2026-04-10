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

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.treesitter.start()
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

local ensureInstalled = {
  'css',
  'go',
  'html',
  'javascript',
  'json',
  'jsx',
  'lua',
  'markdown',
  'ruby',
  'rust',
  'tsx',
  'typescript',
}
local alreadyInstalled = require('nvim-treesitter.config').get_installed()
local parsersToInstall = vim
  .iter(ensureInstalled)
  :filter(function(parser)
    return not vim.tbl_contains(alreadyInstalled, parser)
  end)
  :totable()

require('nvim-treesitter').install(parsersToInstall)

require('nvim-treesitter-textobjects').setup {}

require('treesitter-context').setup {
  max_lines = 3,
  trim_scope = 'inner',
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

require('nvim-ts-autotag').setup()
