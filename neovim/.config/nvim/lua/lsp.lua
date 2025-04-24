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
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    -- map('gri', vim.lsp.buf.implementation, 'Go to implementation')
    map('gt', vim.lsp.buf.type_definition, 'Go to type definition')
    map('grs', vim.lsp.buf.document_symbol, 'Document symbols')
    -- map('g.', vim.lsp.buf.code_action, 'Code actions')
    map('g,', vim.lsp.buf.signature_help, 'Signature Help')
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

local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file('after/lsp/*.lua', true)) do
  local server_name = vim.fn.fnamemodify(f, ':t:r')
  table.insert(lsp_configs, server_name)
end

vim.lsp.inlay_hint.enable()
vim.diagnostic.config { virtual_text = true }

vim.lsp.enable {
  -- npm
  'ts_ls',
  'cssls',
  'html',
  'jsonls',
  -- brew
  'lua_ls',
  -- gem
  'ruby_lsp',
  'rubocop',
  -- rustup component
  'rust_analyzer',
}
