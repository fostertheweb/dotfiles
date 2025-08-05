local M = {}

M.open_pr_diff = function()
  local git_root = vim.fn.system 'git rev-parse --show-toplevel'
  local file_path = vim.api.nvim_buf_get_name(0)
  local relative_path = string.gsub(file_path, git_root .. '/', '')
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local command = string.format('git blame --abbrev=40 -L %d,%d %s', line_number, line_number, relative_path)
  local commit = vim.fn.system(command)
  local hash = vim.fn.system('cut -d" " -f1', commit)
  local pr_number = vim.fn.system('gh pr list --state=merged --json number --jq ".[0].number" --search=' .. hash)

  if #pr_number == 0 then
    vim.notify('No pull requests containing commit: ' .. hash)
  else
    vim.fn.system('gh pr diff --web ' .. pr_number)
  end
end

M.is_dark_mode = function()
  local handle = io.popen 'osascript -e \'tell application "System Events" to tell appearance preferences to get dark mode\''

  if handle then
    local result = handle:read '*a'
    handle:close()
    return result:match 'true' ~= nil
  end

  return true
end

M.close_tab_or_quit = function()
  if #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd 'tabclose'
  else
    vim.cmd 'quit'
  end
end

M.get_colors = function(hl_group)
  local hl = vim.api.nvim_get_hl(0, { name = hl_group, link = false })

  local guifg = string.format('#%06x', hl.fg or 0)
  local guibg = string.format('#%06x', hl.bg or 0)

  return {
    guifg = guifg,
    guibg = guibg,
  }
end

return M
