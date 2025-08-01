local function is_cursor_on_diagnostic()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1] - 1
  local col = cursor[2]

  local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

  for _, diag in ipairs(diagnostics) do
    if col >= diag.col and col <= diag.end_col then
      return true
    end
  end

  return false
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('g.', vim.lsp.buf.code_action, 'Code actions')
    map('gk', vim.lsp.buf.signature_help, 'Signature Help')
    map('g=', vim.lsp.buf.format, 'Format code')

    map('K', function()
      if is_cursor_on_diagnostic() then
        vim.diagnostic.open_float()
      else
        vim.lsp.buf.hover()
      end
    end, 'Show diagnostic or LSP hover')
  end,
})

-- Options
vim.lsp.inlay_hint.enable()
vim.diagnostic.config { virtual_text = true }

vim.lsp.enable {
  -- npm
  'ts_ls',
  'cssls',
  'html',
  'jsonls',
  'tailwindcss',
  -- brew
  'lua_ls',
  -- gem
  'ruby_lsp',
  'rubocop',
  -- rustup component
  'rust_analyzer',
  -- system
  'sourcekit',
}
