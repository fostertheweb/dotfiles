local utils = require 'utils'

vim.pack.add {
  'https://github.com/zitrocode/carvion.nvim',
  'https://github.com/lucasadelino/conifer.nvim',
  'https://github.com/savq/melange-nvim',
  'https://github.com/thallada/farout.nvim',
  'https://github.com/shoenot/witchesbrew.nvim',
  'http://github.com/oskarnurm/koda.nvim',
}

require('conifer').setup {
  transparent = false,
}

-- Default theme settings
vim.cmd.hi 'Comment gui=none'

if utils.is_work_computer() then
  vim.o.background = 'dark'
  vim.cmd 'colorscheme melange'
else
  vim.o.background = 'dark'
  vim.cmd 'colorscheme koda'
end
