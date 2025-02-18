local M = {}

local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })

vim.api.nvim_set_hl(0, 'GitDiffAdd', { fg = '#a9c99f' })
vim.api.nvim_set_hl(0, 'GitDiffDel', { fg = '#f3a0a0' })
vim.api.nvim_set_hl(0, 'FilenameBold', { fg = normal_hl.fg, bg = 'NONE', bold = true })

-- highlight color for no problems, errors or warnings
local function lsp_status()
  if vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR }) then
    return string.format('%%#DiagnosticError#%s', '!')
  elseif vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN }) then
    return string.format('%%#DiagnosticWarn#%s', '*')
  else
    return string.format('%%#DiagnosticOk#%s', '%%')
  end
end

-- highlight color for saved or unsaved buffer
local function modified_status() end

-- Returns a string for the file path (excluding the filename).
local function file_path_component()
  local full_path = vim.fn.expand '%:p:h'

  if full_path == '' then
    return ''
  end

  local cwd = vim.fn.getcwd()
  -- If the full path starts with the cwd, remove it along with the trailing separator
  if full_path:sub(1, #cwd) == cwd then
    full_path = full_path:sub(#cwd + 2) -- +2 to remove the slash as well
  end
  -- Split the remaining path by the directory separator
  local sep = package.config:sub(1, 1) -- get system's path separator
  local dirs = vim.split(full_path, sep, { plain = true })
  local joined = table.concat(dirs, string.format '%%#SpecialKey#  ')
  return string.format('%%#SpecialKey# %s ', joined)
end

local function buffer_number()
  return string.format('%%#SpecialKey# %d%%#NonText#:', vim.api.nvim_get_current_buf())
end

local function buffer_status()
  if vim.bo.modified then
    return string.format('%%#DiagnosticWarn#%s', '*')
  else
    return string.format('%%#Normal#%s', '%%')
  end
end

local function file_name_component()
  local filename = vim.fn.expand '%:t'

  if filename == '' then
    return ''
  end

  local extension = vim.fn.expand '%:e'
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  local icon = nil

  if has_devicons then
    local icons = devicons.get_icons()
    local name = devicons.get_icon_name_by_filetype(extension)
    icon = icons[name] or devicons.get_default_icon()
    vim.api.nvim_set_hl(0, 'IconColor', { fg = icon.color, bg = 'NONE', bold = true })
  end

  if icon == nil then
    return nil
  end

  return string.format('%%#IconColor# %s %%#FilenameBold# %s ', icon.icon, filename)
end

local function git_diff_component()
  -- Run git diff on the entire repo. Adjust the revision (e.g. HEAD) as needed.
  local output = vim.fn.system 'git diff --shortstat HEAD'
  if output == '' then
    return ''
  end
  -- Look for the numbers. The output might be like: " 3 files changed, 45 insertions(+), 10 deletions(-)"
  local ins = output:match '(%d+)%s+insertions?%(%+%)'
  local dels = output:match '(%d+)%s+deletions?%(%-%)'
  ins = ins or '0'
  dels = dels or '0'
  return string.format('%%#GitDiffAdd#+%s %%#GitDiffDel#-%s ', ins, dels)
end

function M.statusline()
  local left = buffer_number() .. buffer_status() .. lsp_status() .. file_name_component()
  local right = file_path_component() .. git_diff_component()
  -- Use %=% to push right side to the far right.
  return left .. ' %=' .. right
end

function M.inactive_statusline()
  return string.format('%%#NonText#%s', '%F')
end

return M
