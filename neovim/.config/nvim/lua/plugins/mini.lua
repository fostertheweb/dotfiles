return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.bufremove').setup()
    require('mini.comment').setup {
      options = {
        ignore_blank_line = true,
      },
      mappings = {
        comment = 'g/',
        comment_line = 'g<space>',
        comment_visual = 'g/',
        textobject = 'g/',
      },
    }
    require('mini.files').setup {
      mappings = {
        go_in = '',
        go_in_plus = 'l',
      },
      windows = {
        preview = true,
        max_number = 3,
        width_focus = 30,
        width_nofocus = 30,
        width_preview = 80,
      },
    }
    require('mini.indentscope').setup {
      draw = {
        animation = function()
          return 0
        end,
      },
      symbol = '│',
    }
    require('mini.pairs').setup()
    require('mini.surround').setup()

    vim.keymap.set('n', '-', function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      require('mini.files').open(path)
      require('mini.files').reveal_cwd()
    end, { desc = 'Open file explorer' })
  end,
}
