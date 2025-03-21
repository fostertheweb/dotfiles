return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.comment').setup {
      options = {
        ignore_blank_line = true,
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end,
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

    local notify_win_config = function()
      local has_statusline = vim.o.laststatus > 0
      local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
      return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - bottom_space }
    end

    require('mini.notify').setup {
      window = {
        config = notify_win_config,
      },
    }

    require('mini.pairs').setup {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    }

    require('mini.surround').setup()

    vim.keymap.set('n', '-', function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      require('mini.files').open(path)
      require('mini.files').reveal_cwd()
    end, { desc = 'Open file explorer' })
  end,
}
