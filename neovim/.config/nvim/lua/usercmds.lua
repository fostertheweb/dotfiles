---@diagnostic disable: undefined-global
vim.api.nvim_create_user_command('ProjectFiles', function()
  require('snacks').picker.files {
    hidden = true,
    preview = function()
      return false
    end,
  }
end, {})
