vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/dmmulroy/ts-error-translator.nvim',
}

require('ts-error-translator').setup()

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
      vim.bo[event.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
      local capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('mini.completion').get_lsp_capabilities())
      vim.lsp.config('*', { capabilities = capabilities })
    end

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Go to definition')
    map('g.', vim.lsp.buf.code_action, 'Code actions')
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

vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(ev)
    local value = ev.data.params.value
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    vim.api.nvim_echo({ { value.kind == 'end' and '✓' or '◐' } }, false, {
      id = 'lsp.' .. ev.data.client_id,
      kind = 'progress',
      source = 'vim.lsp',
      title = ('[%s] %s'):format(client.name, value.title),
      status = value.kind ~= 'end' and 'running' or 'success',
      percent = value.percentage,
    })
  end,
})

-- Options
vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
vim.lsp.inlay_hint.enable()
vim.diagnostic.config {
  update_in_insert = true,
  virtual_text = true,
}

vim.lsp.config('vtsls', {
  settings = {
    typescript = {
      preferences = {
        includePackageJsonAutoImports = 'on',
      },
    },
  },
})

vim.lsp.config('copilot', {
  cmd = { 'copilot-language-server', '--stdio' },
  init_options = {
    editorInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
    editorPluginInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
  },
})

vim.lsp.inline_completion.enable()

vim.keymap.set('i', '<C-f>', function()
  if not vim.lsp.inline_completion.get() then
    return '<C-f>'
  end
end, { expr = true, desc = 'Accept the current inline completion' })

vim.lsp.enable {
  -- npm
  'copilot',
  'vtsls',
  'cssls',
  'html',
  'jsonls',
  'tailwindcss',
  'eslint',
  -- pkg
  'gopls',
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
