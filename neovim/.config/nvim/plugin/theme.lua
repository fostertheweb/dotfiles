local utils = require 'utils'

vim.pack.add {
  'https://github.com/zitrocode/carvion.nvim',
  'https://github.com/thallada/farout.nvim',
  'https://github.com/savq/melange-nvim',
  'https://github.com/reobin/olive-crt.nvim',
  'https://github.com/shoenot/witchesbrew.nvim',
}

-- Default theme settings
vim.cmd.hi 'Comment gui=none'
vim.o.background = 'dark'

if utils.is_work_computer() then
  vim.cmd 'colorscheme witchesbrew-bright'
else
  if utils.is_dark_mode() then
    vim.cmd 'colorscheme carvion'
  else
    vim.cmd 'colorscheme olive-crt'
  end
end
