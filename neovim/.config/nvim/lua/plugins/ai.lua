return {
  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    dependencies = { 'AndreM222/copilot-lualine' },
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<C-f>',
            accept_word = '<C-l>',
            accept_line = '<C-e>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      }
    end,
  },
  {
    'piersolenski/wtf.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'folke/snacks.nvim',
    },
    opts = {},
  },
}
