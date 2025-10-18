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

vim.api.nvim_create_user_command('PRReview', function()
  vim.schedule(function()
    local ok, gitsigns = pcall(require, 'gitsigns')
    if not ok then
      vim.notify('Gitsigns not available', vim.log.levels.ERROR)
      return
    end

    gitsigns.change_base 'origin/HEAD'
    gitsigns.toggle_linehl()
    gitsigns.setqflist()

    vim.cmd 'copen'
  end)
end, {})
