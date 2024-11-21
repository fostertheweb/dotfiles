return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    cmdline = {
      enabled = true,
      view = 'cmdline',
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    messages = {
      enabled = true,
      view = 'mini',
      view_error = 'notify',
      view_warn = 'notify',
      view_history = 'messages',
      view_search = 'virtualtext',
    },
    presets = {
      bottom_search = true,
      command_palette = false,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
}
