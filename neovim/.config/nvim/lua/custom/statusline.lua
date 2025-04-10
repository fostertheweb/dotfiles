local M = {}

local diff_add_hl = vim.api.nvim_get_hl(0, { name = 'DiffAdd', link = false })
local diff_delete_hl = vim.api.nvim_get_hl(0, { name = 'DiffDelete', link = false })

vim.api.nvim_set_hl(0, 'SimpleLineGitDiffAdd', { fg = diff_add_hl.fg })
vim.api.nvim_set_hl(0, 'SimpleLineGitDiffDel', { fg = diff_delete_hl.fg })

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

  return string.format('%%#NonText# %s %s ', ' ', joined)
end

local function lsp_status()
  local counts = vim.diagnostic.count(nil, {
    severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
  })
  local error_count = counts[vim.diagnostic.severity.ERROR] or 0
  local warn_count = counts[vim.diagnostic.severity.WARN] or 0
  local problem_count = error_count + warn_count

  if error_count > 0 then
    return string.format('%%#DiagnosticSignError#%s %d', '!', problem_count)
  else
    return string.format('%%#DiagnosticSignOk#%s', '  ')
  end
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

  return string.format('%%#SimpleLineGitDiffAdd#+%s %%#SimpleLineGitDiffDel#-%s ', ins, dels)
end

function M.statusline()
  local left = git_branch() .. git_diff_component()
  local right = lsp_status() .. file_path_component()
  -- Use %=% to push right side to the far right.
  return left .. ' %=' .. right
end

return M
