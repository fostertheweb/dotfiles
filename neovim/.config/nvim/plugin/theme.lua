local utils = require 'utils'

vim.pack.add {
  'https://github.com/zitrocode/carvion.nvim',
  'https://github.com/lucasadelino/conifer.nvim',
  'https://github.com/thallada/farout.nvim',
  'http://github.com/oskarnurm/koda.nvim',
  'https://github.com/savq/melange-nvim',
  'https://github.com/pisgahk/muted.nvim',
  'https://github.com/reobin/olive-crt.nvim',
  'https://github.com/shoenot/witchesbrew.nvim',
}

require('conifer').setup {
  transparent = false,
}

-- Default theme settings
vim.cmd.hi 'Comment gui=none'

if utils.is_work_computer() then
  vim.o.background = 'dark'
  vim.cmd 'colorscheme muted_autumn'
else
  if utils.is_dark_mode() then
    vim.o.background = 'dark'
    vim.cmd 'colorscheme koda'
  else
    vim.o.background = 'light'
    vim.cmd 'colorscheme koda-moss'
  end
end
