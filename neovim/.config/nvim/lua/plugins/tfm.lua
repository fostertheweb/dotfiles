return {
  'rolv-apneseth/tfm.nvim',
  lazy = false,
  config = function()
    require('tfm').setup {
      file_manager = 'lf',
      replace_netrw = true,
      enable_cmds = false,
      ui = {
        border = 'none',
        height = 0.96,
        width = 0.96,
        x = 0.04,
        y = 0.04,
      },
    }

    vim.api.nvim_set_keymap('n', '-', '', {
      noremap = true,
      callback = function()
        require('tfm').open()
      end,
    })
  end,
}
