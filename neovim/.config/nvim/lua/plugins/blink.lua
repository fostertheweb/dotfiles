return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  enabled = true,
  version = 'v0.*',
  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    signature = { enabled = true },
  },
}
