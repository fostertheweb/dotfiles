local M = {}

local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
local exception_hl = vim.api.nvim_get_hl(0, { name = 'Exception', link = false })

vim.api.nvim_set_hl(0, 'ModeNormal', { fg = '#a9c99f' })
vim.api.nvim_set_hl(0, 'ModeInsert', { fg = '#6fb3c0' })
vim.api.nvim_set_hl(0, 'ModeVisual', { fg = '#d0b0ff' })
vim.api.nvim_set_hl(0, 'ModeCommand', { fg = '#f79000' })
vim.api.nvim_set_hl(0, 'ModeReplace', { fg = exception_hl.fg })
vim.api.nvim_set_hl(0, 'ModeTerminal', { fg = '#f498c0' })
vim.api.nvim_set_hl(0, 'LinePath', { fg = '#8f8886' })
-- vim.api.nvim_set_hl(0, 'GitBranch', { fg = '#b0a0cf' })
vim.api.nvim_set_hl(0, 'GitDiffAdd', { fg = '#a9c99f' })
vim.api.nvim_set_hl(0, 'GitDiffDel', { fg = '#f3a0a0' })
vim.api.nvim_set_hl(0, 'FilenameBold', { fg = normal_hl.fg, bg = 'NONE', bold = true })

-- Define a mapping from mode to label and highlight group (colors you can set via hi commands)
local mode_map = {
  n = { label = 'NORMAL', hl = 'ModeNormal' },
  i = { label = 'INSERT', hl = 'ModeInsert' },
  v = { label = 'VISUAL', hl = 'ModeVisual' },
  V = { label = 'V-LINE', hl = 'ModeVisual' },
  [''] = { label = 'V-BLOCK', hl = 'ModeVisual' },
  c = { label = 'COMMAND', hl = 'ModeCommand' },
  R = { label = 'REPLACE', hl = 'ModeReplace' },
  t = { label = 'TERMINAL', hl = 'ModeTerminal' },
}

-- Returns a string for the mode component.
local function mode_component()
  local mode = vim.api.nvim_get_mode().mode
  local info = mode_map[mode] or { label = mode, hl = 'ModeNormal' }
  return string.format('%%#%s#󰝤 󰔶  ', info.hl)
end

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

-- Returns a string for the filename along with its filetype icon.
local function file_name_component()
  local filename = vim.fn.expand '%:t'
  if filename == '' then
    return ''
  end
  -- Get the file extension and then fetch the devicon using nvim-web-devicons.
  local extension = vim.fn.expand '%:e'
  local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
  local icon = nil
  if has_devicons then
    local icons = devicons.get_icons()
    local name = devicons.get_icon_name_by_filetype(extension)
    icon = icons[name] or devicons.get_default_icon()
    vim.api.nvim_set_hl(0, 'IconColor', { fg = icon.color, bg = 'NONE', bold = true })
  end
  -- Wrap the filename in a bold highlight group.
  if icon == nil then
    return nil
  end
  return string.format('%%#IconColor# %s %%#SpecialKey# %d:%%#FilenameBold#%s ', icon.icon, vim.api.nvim_get_current_buf(), filename)
end

-- Returns a string for the git branch using gitsigns.
local function git_branch_component()
  local signs = vim.b.gitsigns_status_dict or {}
  local branch = signs.head or ''
  if branch ~= '' then
    return string.format('%%#GitBranch# %s ', branch)
  else
    return ''
  end
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

local separator = function()
  return string.format('%%#NonText# %s', '󰿟󰿟')
end

-- Combine all parts into one statusline string.
function M.statusline()
  -- Left side: mode, file path and filename.
  local left = mode_component() .. separator() .. file_name_component()
  -- Right side: git branch then diff.
  local right = file_path_component() .. git_diff_component()
  -- Use %=% to push right side to the far right.
  return left .. ' %=' .. right
end

function M.inactive_statusline()
  return string.format('%%#NonText#%s', '%F')
end

return M
