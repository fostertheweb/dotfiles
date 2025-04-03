---@diagnostic disable: undefined-global
vim.api.nvim_create_user_command('QuickLint', function()
  vim.fn.setqflist {}

  local eslint_cmd = { 'npx', 'eslint', '--format', 'unix', '.' }
  local output = {}

  -- Create pipes for stdout and stderr
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local handle
  handle = vim.loop.spawn(eslint_cmd[1], {
    args = { table.unpack(eslint_cmd, 2) },
    stdio = { nil, stdout, stderr },
  }, function(code)
    if code ~= 0 then
      local tmpfile = vim.fn.tempname()
      vim.fn.writefile(output, tmpfile)

      local old_efm = vim.o.errorformat
      -- Set the errorformat for ESLint's unix format
      vim.o.errorformat = '%f:%l:%c: %m'

      vim.cmd('cfile ' .. tmpfile)
      vim.o.errorformat = old_efm

      vim.cmd 'copen'
      vim.fn.delete(tmpfile)
    else
      vim.notify('ESLint: No errors found', vim.log.levels.INFO)
    end

    handle:close()
  end)

  if handle then
    stdout:read_start(function(err, data)
      assert(not err, err)
      if data then
        vim.list_extend(output, vim.split(data, '\n'))
      end
    end)
  else
    vim.notify('Failed to start ESLint process', vim.log.levels.ERROR)
  end
end, {})

vim.api.nvim_create_user_command('ProjectFiles', function()
  require('snacks').picker.files { hidden = true, preview = false }
end, {})
