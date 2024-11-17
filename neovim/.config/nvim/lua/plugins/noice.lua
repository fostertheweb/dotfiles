return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    messages = {
      enabled = true,
      view = 'mini',
      view_error = 'notify',
      view_warn = 'notify',
      view_history = 'messages',
      view_search = 'virtualtext',
    },
    presets = {
      bottom_search = false,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
