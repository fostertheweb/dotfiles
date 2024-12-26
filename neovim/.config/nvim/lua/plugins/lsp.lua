return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    vim.lsp.inlay_hint.enable()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        map('gd', vim.lsp.buf.definition, 'Go to fefinition')
        map('gt', vim.lsp.buf.type_definition, 'Go to type definition')
        map('gI', vim.lsp.buf.implementation, 'Go to implementation')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('grr', vim.lsp.buf.references, 'Go to References')
        map('grn', vim.lsp.buf.rename, 'Rename Symbol')
        map('gra', vim.lsp.buf.code_action, 'Code Actions')
        vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help)

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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

    local servers = {
      eslint_d = {},
      rust_analyzer = {},
      ts_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              -- If lua_ls is really slow on your computer, you can try this instead:
              -- library = { vim.env.VIMRUNTIME },
            },
            completion = {
              callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    -- setup swift lsp
    require('lspconfig').sourcekit.setup {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    }

    require('lspconfig').eslint.setup {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    -- formatters
    vim.list_extend(ensure_installed, {
      'prettier',
      'shfmt',
      'stylua',
    })
    -- linters
    vim.list_extend(ensure_installed, {
      'eslint_d',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
