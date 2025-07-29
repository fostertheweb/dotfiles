return {
  'echasnovski/mini.nvim',
  config = function()
    if not vim.g.vscode then
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
      require('mini.pick').setup()
    end

    require('mini.surround').setup()
  end,
}
