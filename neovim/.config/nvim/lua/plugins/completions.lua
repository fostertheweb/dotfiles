return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
  {
    'hrsh7th/nvim-cmp',
    enabled = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'tailwind-tools',
      'onsails/lspkind-nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup {
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, item)
            if vim.tbl_contains({ 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry.completion_item)
              if icon then
                item.kind = icon
                item.kind_hl_group = hl_group
                return item
              end
            end

            local fmt = require('lspkind').cmp_format {
              with_text = false,
              mode = 'symbol_text',
              maxwidth = 50,
              ellipsis_char = '...',
              before = require('tailwind-tools.cmp').lspkind_format,
            }(entry, item)

            local strings = vim.split(fmt.kind, '%s', { trimempty = true })
            fmt.kind = ' ' .. (strings[1] or '') .. ' '
            fmt.menu = '  ' .. (strings[2] or ' ')

            return fmt
          end,
        },
        completion = {
          keyword_length = 1,
          completeopt = 'menu,menuone,noinsert',
        },
        cmdline = {
          mapping = {},
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-c>'] = cmp.mapping.abort(),
        },
        matching = {
          disallow_partial_fuzzy_matching = false,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'lazydev', group_index = 0 },
        },
        window = {
          completion = {
            border = 'rounded',
            col_offset = -4,
            side_padding = 1,
            scrollbar = false,
            winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
          },
          documentation = {
            border = 'rounded',
            max_width = 80,
            max_height = 20,
            winhighlight = 'Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None',
          },
        },
      }

      cmp.setup.cmdline({ '/', '?' }, {
        completion = { keyword_length = 1 },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'nvim_lsp_document_symbol' },
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        formatting = {
          fields = { 'abbr' },
        },
        mapping = cmp.mapping.preset.cmdline {
          ['<C-n>'] = cmp.config.disable,
          ['<C-p>'] = cmp.config.disable,
          ['<C-j>'] = cmp.config.disable,
        },
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
        window = {
          completion = {
            side_padding = 1,
            scrollbar = false,
            max_height = 20,
          },
        },
      })
    end,
  },
}
