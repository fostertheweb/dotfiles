vim.pack.add {
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
}

require('lualine').setup {
  options = {
    theme = {
      normal = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
      insert = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
      visual = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
      replace = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
      command = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
      inactive = { a = { bg = 'none' }, b = { bg = 'none' }, c = { bg = 'none' } },
    },
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    always_show_tabline = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'filename', 'diagnostics' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = { { 'branch', icon = '' }, 'diff' },
    lualine_z = { 'progress', 'location' },
  },
  inactive_sections = {},
}
