return {
  {
    'neovim/nvim-lspconfig',
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
      {
        'luckasRanarison/tailwind-tools.nvim',
        name = 'tailwind-tools',
        build = ':UpdateRemotePlugins',
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
        },
      },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,
      }

      vim.lsp.inlay_hint.enable()

      -- Diagnostic
      vim.diagnostic.config {
        virtual_text = {
          severity = {
            max = vim.diagnostic.severity.WARN,
          },
        },
        virtual_lines = {
          severity = {
            min = vim.diagnostic.severity.ERROR,
          },
        },
      }

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
  {
    'lewis6991/hover.nvim',
    enabled = false,
    config = function()
      require('hover').setup {
        init = function()
          require 'hover.providers.lsp'
          require 'hover.providers.diagnostic'
        end,
        preview_opts = {
          border = 'rounded',
        },
        preview_window = false,
        title = true,
      }

      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'Show hover' })
      vim.keymap.set('n', '<C-p>', function()
        ---@diagnostic disable-next-line: missing-parameter
        require('hover').hover_switch 'previous'
      end, { desc = 'hover.nvim (previous source)' })
      vim.keymap.set('n', '<C-n>', function()
        ---@diagnostic disable-next-line: missing-parameter
        require('hover').hover_switch 'next'
      end, { desc = 'hover.nvim (next source)' })
    end,
  },
  {
    'oskarrrrrrr/symbols.nvim',
    config = function()
      local r = require 'symbols.recipes'
      require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, {})
      vim.keymap.set('n', 'g0', '<cmd>Symbols<CR>')
    end,
  },
}
