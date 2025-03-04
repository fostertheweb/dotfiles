---@diagnostic disable: undefined-global
return {
  'folke/snacks.nvim',
  opts = {
    bufdelete = {},
    dim = {},
    indent = {},
    input = {},
    picker = {
      matcher = {
        frecency = true,
      },
      ui_select = true,
    },
  },
  keys = {
    {
      '<leader>p',
      function()
        Snacks.picker.files { hidden = true }
      end,
      { desc = 'Files' },
    },
  },
}
