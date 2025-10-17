return {
  'nvim-mini/mini.nvim',
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

    local miniclue = require 'mini.clue'
    miniclue.setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },

      window = {
        -- Floating window config
        config = {},

        -- Delay before showing clue window
        delay = 500,

        -- Keys to scroll inside the clue window
        scroll_down = '<C-d>',
        scroll_up = '<C-u>',
      },
    }

    require('mini.files').setup {
      mappings = {
        go_in = '',
        go_in_plus = 'l',
      },
      windows = {
        preview = false,
        max_number = 2,
        width_focus = 30,
        width_nofocus = 30,
        width_preview = 80,
      },
    }

    vim.keymap.set('n', '-', function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      require('mini.files').open(path)
    end, { desc = 'Open file explorer' })

    require('mini.icons').setup {}
    require('mini.icons').mock_nvim_web_devicons()

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

    require('mini.surround').setup()
  end,
}
