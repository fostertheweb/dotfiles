local function is_cursor_on_diagnostic()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0) -- {line, col}, 1-based line
  local line = cursor[1] - 1 -- diagnostics use 0-based line
  local col = cursor[2]

  local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

  for _, diag in ipairs(diagnostics) do
    if col >= diag.col and col <= diag.end_col then
      return true
    end
  end

  return false
end

return {
  {
    'neovim/nvim-lspconfig',
    cond = not vim.g.vscode,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,
      }

      vim.lsp.inlay_hint.enable()

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          map('gd', vim.lsp.buf.definition, 'Go to definition')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('gri', vim.lsp.buf.implementation, 'Go to implementation')
          map('gt', vim.lsp.buf.type_definition, 'Go to type definition')
          map('grs', vim.lsp.buf.document_symbol, 'Document symbols')
          map('g.', vim.lsp.buf.code_action, 'Code actions')
          map('g,', vim.lsp.buf.signature_help, 'Signature Help')
          map('g=', vim.lsp.buf.format, 'Format code')

          map('K', function()
            if is_cursor_on_diagnostic() then
              vim.diagnostic.open_float()
            else
              vim.lsp.buf.hover()
            end
          end, 'Show diagnostic or LSP hover')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
    end,
  },
}
