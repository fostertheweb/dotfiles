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
        width = 1,
        x = 0.5,
        y = 1,
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
