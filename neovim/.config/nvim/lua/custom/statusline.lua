local M = {}

local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
local warning_hl = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn', link = false })
local diff_add_hl = vim.api.nvim_get_hl(0, { name = 'DiagnosticSignOk', link = false })
local diff_delete_hl = vim.api.nvim_get_hl(0, { name = 'DiagnosticSignError', link = false })

vim.api.nvim_set_hl(0, 'SimpleLineGitDiffAdd', { fg = diff_add_hl.fg })
vim.api.nvim_set_hl(0, 'SimpleLineGitDiffDel', { fg = diff_delete_hl.fg })
vim.api.nvim_set_hl(0, 'SimpleLineFilename', { fg = normal_hl.fg, bg = 'NONE', bold = false })
vim.api.nvim_set_hl(0, 'SimpleLineFilenameModified', { fg = warning_hl.fg, bg = 'NONE', bold = true })

local function file_path_component()
  local full_path = vim.fn.expand '%:p:h'

  if full_path == '' then
    return ''
  end

  local cwd = vim.fn.getcwd()

  if full_path:sub(1, #cwd) == cwd then
    full_path = full_path:sub(#cwd + 2) -- +2 to remove the slash as well
  end

  local sep = package.config:sub(1, 1) -- get system's path separator
  local dirs = vim.split(full_path, sep, { plain = true })
  local joined = table.concat(dirs, string.format '%%#NonText# 󰿟 ')

  return string.format('%%#NonText# %s ', joined)
end

local function buffer_number(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  return string.format('%%#NonText#[%%#SpecialKey#%d%%#NonText#]', bufnr)
end

local function file_name_component()
  local filename = vim.fn.expand '%:t'

  if filename == '' then
    return ''
  end

  local filetype = vim.bo.filetype
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  local icon = nil

  if has_devicons then
    local icons = devicons.get_icons()
    local name = devicons.get_icon_name_by_filetype(filetype)
    icon = icons[name] or devicons.get_default_icon()
    vim.api.nvim_set_hl(0, 'IconColor', { fg = icon.color, bg = 'NONE', bold = true })
  end

  if icon == nil then
    return nil
  end

  local filename_hl = 'SimpleLineFilename'

  if vim.bo.modified then
    filename_hl = 'SimpleLineFilenameModified'
    filename = filename .. '*'
  end

  return string.format(' %%#IconColor# %s %%#%s# %s ', icon.icon, filename_hl, filename)
end

local function lsp_status()
  local counts = vim.diagnostic.count(nil, {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  })
  local error_count = counts[vim.diagnostic.severity.ERROR] or 0
  local warn_count = counts[vim.diagnostic.severity.WARN] or 0

  if error_count > 0 then
    return string.format('%%#DiagnosticSignError#%s', '! ')
  elseif warn_count > 0 then
    return string.format('%%#DiagnosticSignWarn#%s', '* ')
  else
    return string.format('%%#DiagnosticSignOk#%s', '% ')
  end
end

local function git_diff_component()
  local output = vim.fn.system 'git diff --shortstat HEAD'

  if output == '' then
    return ''
  end

  local ins = output:match '(%d+)%s+insertions?%(%+%)'
  local dels = output:match '(%d+)%s+deletions?%(%-%)'
  ins = ins or '0'
  dels = dels or '0'

  return string.format('%%#SimpleLineGitDiffAdd#+%s %%#SimpleLineGitDiffDel#-%s ', ins, dels)
end

function M.statusline()
  local left = buffer_number() .. file_name_component() .. file_path_component()
  local right = lsp_status() .. git_diff_component()
  -- Use %=% to push right side to the far right.
  return left .. ' %=' .. right
end

function M.inactive_statusline(winid)
  local bufnr = vim.api.nvim_win_get_buf(winid)
  local filename = vim.api.nvim_buf_get_name(bufnr)
  filename = vim.fn.fnamemodify(filename, ':t') -- Get just the tail (filename)

  if filename == '' then
    filename = '[No Name]'
  end

  local buffer_status = '-'
  if vim.api.nvim_get_option_value('modified', { buf = bufnr }) then
    buffer_status = '+'
  end

  return buffer_number(bufnr) .. string.format('  %%#NonText#%s %s', buffer_status, filename)
end

return M
