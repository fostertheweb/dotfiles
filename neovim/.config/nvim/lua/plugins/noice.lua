return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {},
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('noice').setup {
      views = {
        popup = {
          border = {
            style = 'single',
          },
        },
        popupmenu = {
          border = {
            style = 'single',
          },
        },
        cmdline = {
          border = {
            style = 'single',
          },
        },
        cmdline_input = {
          border = {
            style = 'single',
          },
        },
        cmdline_popup = {
          border = {
            style = 'single',
          },
        },
      },
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
    }
  end,
}
