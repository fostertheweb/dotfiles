local utils = require 'utils'

vim.pack.add {
  'https://github.com/zitrocode/carvion.nvim',
  'https://github.com/thallada/farout.nvim',
  'https://github.com/metalelf0/kintsugi-nvim',
  'https://github.com/savq/melange-nvim',
  'https://github.com/reobin/olive-crt.nvim',
  'https://github.com/arnauKL/south.nvim',
  'https://github.com/shoenot/witchesbrew.nvim',
}

require('south').setup {
  transparent = false,
  darker_floats = true,
  styles = {
    italics = true,
    italic_comments = true,
    italic_linenums = false,
    bold_keywords = true,
  },
}

-- Default theme settings
vim.cmd.hi 'Comment gui=none'
vim.o.background = 'dark'

if utils.is_work_computer() then
  if utils.is_dark_mode() then
    vim.cmd 'colorscheme carvion'
  else
    vim.cmd 'colorscheme south'
  end
else
  if utils.is_dark_mode() then
    vim.cmd 'colorscheme carvion'
  else
    vim.cmd 'colorscheme olive-crt'
  end
end
