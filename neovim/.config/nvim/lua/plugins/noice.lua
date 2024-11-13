return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      long_message_to_split = true, -- long messages will be sent to a split
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
