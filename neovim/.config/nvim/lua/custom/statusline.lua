local utils = require 'utils'
local devicons = require 'nvim-web-devicons'

local M = {}

M.file_path_component = function()
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
  local joined = table.concat(dirs, string.format '%%#Whitespace# 󰿟 ')

  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')

  if filename == '' then
    return ''
  end

  return string.format('%%#Whitespace# %s %s 󰿟', ' ', joined)
end

M.file_name_component_1 = function()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
  filename = (filename ~= '' and filename) or '[No Name]'
  local modified = vim.bo[0].modified

  local modified_fg = utils.get_colors('MiniIconsOrange').guifg
  vim.api.nvim_set_hl(0, 'SimpleLineFilename', { fg = utils.get_colors('Normal').fg, bold = true })
  vim.api.nvim_set_hl(0, 'SimpleLineFilenameModified', { fg = modified_fg, italic = true, bold = true })

  if filename == '[No Name]' then
    return string.format('%%#Comment#%s', filename)
  end

  if modified then
    return string.format('%%#SimpleLineFilenameModified#%s', filename)
  end

  return string.format('%%#SimpleLineFilename#%s', filename)
end

M.file_name_component = function()
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')
  filename = (filename ~= '' and filename) or '[No Name]'
  local modified = vim.bo[0].modified
  local filetype = vim.bo[0].filetype
  local buftype = vim.bo[0].buftype

  local ft_icon, ft_color

  -- For terminals, use the filetype (e.g., 'zsh', 'bash') to get icon
  if buftype == 'terminal' then
    if filetype ~= '' then
      ft_icon, ft_color = devicons.get_icon_color_by_filetype(filetype)
    end
    if not ft_icon then
      ft_icon, ft_color = devicons.get_icon_color 'terminal'
    end
    filename = vim.fn.bufname('%'):match '[^:]+$' or 'terminal'
    if filename and filename:match '^%d+:' then
      filename = filename:gsub('^%d+:', '')
    end
  -- For special buffer types, try filetype first
  elseif buftype ~= '' then
    if filetype ~= '' then
      ft_icon, ft_color = devicons.get_icon_color_by_filetype(filetype)
    end
    if not ft_icon then
      ft_icon, ft_color = devicons.get_icon_color(filename)
    end
  else
    -- Normal files: try filename first, fallback to filetype
    ft_icon, ft_color = devicons.get_icon_color(filename)
    if not ft_icon and filetype ~= '' then
      ft_icon, ft_color = devicons.get_icon_color_by_filetype(filetype)
    end
  end

  local modified_fg = utils.get_colors('MiniIconsOrange').guifg
  vim.api.nvim_set_hl(0, 'SimpleLineFileIcon', { fg = ft_color })
  vim.api.nvim_set_hl(0, 'SimpleLineFilename', { fg = utils.get_colors('Normal').fg, bold = true })
  vim.api.nvim_set_hl(0, 'SimpleLineFilenameModified', { fg = modified_fg, italic = true, bold = true })

  if ft_icon == nil then
    ft_icon = ''
  end

  if filename == '[No Name]' then
    return string.format('%%#Comment# %s  %s ', ft_icon, filename)
  end

  if buftype == 'terminal' then
    return string.format('%%#SimpleLineFileIcon#%s  %s ', ft_icon, filename)
  end

  if vim.bo.buftype == 'terminal' then
    ft_icon, ft_color = devicons.get_icon_color 'term://zsh'
    filename = vim.fn.bufname('%'):match('[^:]+$'):gsub('^%d+:', '')
    return string.format('%%#SimpleLineFileIcon#%s  %s ', ft_icon, filename)
  end

  if modified then
    return string.format('%%#SimpleLineFilenameModified#%s %s ', ' ', filename)
  end

  return string.format('%%#SimpleLineFileIcon#%s  %%#SimpleLineFilename#%s ', ft_icon, filename)
end

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
  local joined = table.concat(dirs, string.format '%%#Comment# 󰿟 ')

  if vim.bo[0].buftype == 'terminal' then
    return ''
  end

  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t')

  if filename == '' then
    return ''
  end

  return string.format('%%#Comment# %s %s 󰿟', ' ', joined)
end

local function lsp_status()
  local counts = vim.diagnostic.count(nil, {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  })
  local error_count = counts[vim.diagnostic.severity.ERROR] or 0
  local warn_count = counts[vim.diagnostic.severity.WARN] or 0

  local errors = string.format('%%#DiagnosticError#%s%d', '  ', error_count)
  local warnings = string.format('%%#DiagnosticWarn#%s%d', '  ', warn_count)

  return table.concat { (error_count > 0 and errors) or '', ' ', (warn_count > 0 and warnings) or '' }
end

local function git_branch()
  local branch = vim.fn.system 'git rev-parse --abbrev-ref HEAD'

  if branch == 'HEAD' then
    return ''
  end

  return string.format('%%#Comment#   %s ', vim.trim(branch))
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

  return string.format('%%#DiagnosticOk#+%s %%#DiagnosticError#-%s ', ins, dels)
end

function M.active()
  vim.api.nvim_set_hl(0, 'StatusLine', { bg = utils.get_colors('NormalNC').bg })

  local left = file_path_component() .. file_name_component() .. lsp_status()
  local right = git_branch() .. git_diff_component()
  -- Use %=% to push right side to the far right.
  return left .. ' %=' .. right
end

return M
