return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = true,
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = {
      timeout_ms = 500,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofmt', 'goimports' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
