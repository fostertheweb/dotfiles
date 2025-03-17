vim.api.nvim_create_user_command('QuickLint', function()
  vim.fn.setqflist {}

  -- local file_path = vim.fn.expand '%:p'
  local eslint_cmd = 'npx eslint --format unix .' -- .. file_path
  local eslint_output = vim.fn.system(eslint_cmd)

  if vim.v.shell_error ~= 0 then
    local tmpfile = vim.fn.tempname()
    vim.fn.writefile(vim.fn.split(eslint_output, '\n'), tmpfile)

    local old_efm = vim.o.errorformat

    -- Set the errorformat for ESLint's unix format
    vim.o.errorformat = '%f:%l:%c: %m'

    vim.cmd('cfile ' .. tmpfile)
    vim.o.errorformat = old_efm

    vim.cmd 'copen'
    vim.fn.delete(tmpfile)
  else
    print 'ESLint: No errors found'
  end
end, {})
