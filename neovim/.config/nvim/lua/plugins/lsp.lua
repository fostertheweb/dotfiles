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
        opts = {},
      },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      local on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      end

      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
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
          map('gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('go', vim.lsp.buf.type_definition, 'Go to type definition')
          map('gr', vim.lsp.buf.references, 'Go to references')
          map('gc', vim.lsp.buf.rename, 'Rename symbol')
          map('g.', vim.lsp.buf.code_action, 'Code actions')
          map('g,', vim.lsp.buf.signature_help, 'Signature Help')
          map('=g', vim.lsp.buf.format, 'Format code')
          vim.keymap.set('i', '<C-i>', vim.lsp.buf.signature_help)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
    end,
  },
  {
    'lewis6991/hover.nvim',
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
}
