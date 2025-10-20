---@diagnostic disable: undefined-global
vim.api.nvim_create_user_command('ProjectFiles', function()
  require('snacks').picker.smart {
    hidden = true,
    preview = false,
  }
end, {})

vim.api.nvim_create_user_command('ESLintAsync', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  -- Create a temporary job to run eslint
  local job_id = vim.fn.jobstart('eslint_d --format json ' .. vim.fn.shellescape(filename), {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data or #data == 0 or not data[1] or data[1] == '' then
        vim.notify('No ESLint issues found', vim.log.levels.INFO)
        return
      end

      -- Parse the JSON output
      local ok, parsed = pcall(vim.json.decode, table.concat(data, '\n'))
      if not ok or not parsed or #parsed == 0 then
        vim.notify('Failed to parse ESLint output', vim.log.levels.ERROR)
        return
      end

      -- Convert ESLint results to quickfix items
      local qf_items = {}
      for _, file in ipairs(parsed) do
        for _, message in ipairs(file.messages) do
          table.insert(qf_items, {
            filename = file.filePath,
            lnum = message.line or 0,
            col = message.column or 0,
            text = message.message .. ' [' .. message.ruleId .. ']',
            type = message.severity == 2 and 'E' or 'W',
          })
        end
      end

      -- Populate the quickfix list
      vim.fn.setqflist(qf_items, 'r')

      -- Open the quickfix window if there are items
      if #qf_items > 0 then
        vim.cmd 'copen'
        vim.notify('Found ' .. #qf_items .. ' ESLint issues', vim.log.levels.INFO)
      else
        vim.notify('No ESLint issues found', vim.log.levels.INFO)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 and data[1] ~= '' then
        vim.notify('ESLint error: ' .. table.concat(data, '\n'), vim.log.levels.ERROR)
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 and exit_code ~= 1 then
        -- Exit code 1 is normal when linting errors are found
        vim.notify('ESLint exited with code ' .. exit_code, vim.log.levels.ERROR)
      end
    end,
  })

  if job_id <= 0 then
    vim.notify('Failed to start ESLint job', vim.log.levels.ERROR)
  else
    vim.notify('Running ESLint asynchronously...', vim.log.levels.INFO)
  end
end, {})

local function update_path_with_fd()
  if vim.fn.executable 'fd' == 1 then
    local fd_results = vim.fn.systemlist 'fd --type f --hidden --follow --exclude .git'
    local dirs = {}
    for _, file in ipairs(fd_results) do
      local dir = vim.fn.fnamemodify(file, ':h')
      dirs[dir] = true
    end
    local path_list = {}
    for dir, _ in pairs(dirs) do
      table.insert(path_list, dir)
    end
    vim.o.path = table.concat(path_list, ',')
  end
end

vim.api.nvim_create_user_command('UpdatePath', update_path_with_fd, {})

-- PR file highlight groups
local function setup_pr_highlights()
  local highlights = {
    -- Core PR elements
    { 'PRTitle', { fg = '#ffffff', bold = true } },
    { 'PRNumber', { fg = '#8b949e', italic = true } },
    { 'PRState', { fg = '#238636', bold = true } },
    { 'PRStateClosed', { fg = '#da3633', bold = true } },
    { 'PRStateDraft', { fg = '#8b949e', bold = true } },
    
    -- User/assignee bubbles
    { 'PRUser', { fg = '#ffffff', bg = '#21262d', bold = true } },
    { 'PRUserBorder', { fg = '#30363d' } },
    
    -- Labels
    { 'PRLabel', { fg = '#ffffff', bg = '#1f6feb', bold = true } },
    { 'PRLabelBorder', { fg = '#388bfd' } },
    
    -- Stats and metadata
    { 'PRStats', { fg = '#8b949e' } },
    { 'PRStatsGreen', { fg = '#238636' } },
    { 'PRStatsRed', { fg = '#da3633' } },
    
    -- Section headers
    { 'PRSection', { fg = '#f0f6fc', bold = true } },
    
    -- Description and body text
    { 'PRBody', { fg = '#e6edf3' } },
    { 'PRBodyDim', { fg = '#8b949e' } },
    
    -- Timeline elements
    { 'PRTimeline', { fg = '#656d76' } },
    { 'PRTimelineIcon', { fg = '#8b949e' } },
  }
  
  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl[1], hl[2])
  end
end

-- Utility functions for creating bubble elements
local function create_bubble(text, hl_group, border_hl)
  return {
    { '  ', border_hl or hl_group },
    { text, hl_group },
    { '  ', border_hl or hl_group },
  }
end

local function create_user_bubble(username)
  return create_bubble('@' .. username, 'PRUser', 'PRUserBorder')
end

local function create_label_bubble(label)
  return create_bubble(label, 'PRLabel', 'PRLabelBorder')
end

local function create_stats_text(additions, deletions)
  return {
    { '+' .. additions, 'PRStatsGreen' },
    { ' ', 'PRStats' },
    { '-' .. deletions, 'PRStatsRed' },
  }
end

vim.api.nvim_create_user_command('PRReview', function()
  vim.notify('PR Review', vim.log.levels.INFO)

  -- Set up highlights
  setup_pr_highlights()

  -- Refresh gitsigns first to ensure it detects the worktree properly
  -- vim.cmd 'Gitsigns refresh'

  -- Chain the operations with delays to avoid race conditions
  vim.cmd 'Gitsigns change_base origin/HEAD'

  vim.cmd 'Gitsigns toggle_linehl true'
  vim.cmd 'Gitsigns toggle_deleted true'
  vim.cmd 'Gitsigns toggle_word_diff true'
end, {})

-- Auto-enable PR review mode for git-tracked files with changes in worktrees
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    -- Check if we're in a git worktree (has .git file, not directory)
    if vim.fn.filereadable '.git' == 1 then
      local bufname = vim.api.nvim_buf_get_name(0)
      -- Skip if buffer is not a regular file or is a special buffer type
      if bufname == '' or vim.bo.buftype ~= '' then
        return
      end
      
      -- Check if the file has changes using git diff
      local cmd = 'git diff --name-only origin/HEAD | grep -Fx ' .. vim.fn.shellescape(vim.fn.fnamemodify(bufname, ':~:.'), 1)
      local result = vim.fn.system(cmd)
      
      -- Only enable PRReview if the file has changes
      if vim.v.shell_error == 0 and result:match('%S') then
        vim.defer_fn(function()
          vim.cmd 'PRReview'
        end, 500)
      end
    end
  end,
})
