return {
  {
    'hrsh7th/nvim-cmp',
    enabled = true,
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
          ['<C-j>'] = {
            c = function(_)
              if cmp.visible() then
                if #cmp.get_entries() == 1 then
                  cmp.confirm { select = true }
                else
                  cmp.select_next_item()
                end
              else
                cmp.complete()
                if #cmp.get_entries() == 1 then
                  cmp.confirm { select = true }
                end
              end
            end,
          },
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
