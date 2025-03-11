vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start commit editor in insert mode',
  pattern = 'gitcommit',
  callback = function()
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

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

-- Add this to your Neovim configuration
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    -- Store the current 'shortmess' setting
    local old_shortmess = vim.o.shortmess

    -- Add 's' to shortmess to suppress the written message
    vim.o.shortmess = old_shortmess .. 's'

    -- Set up a one-time autocmd to restore the original shortmess
    vim.api.nvim_create_autocmd('BufWritePost', {
      buffer = 0, -- Only for the current buffer
      once = true, -- Execute only once
      callback = function()
        vim.o.shortmess = old_shortmess
      end,
    })
  end,
})

-- Add this to your Neovim configuration
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    -- Store the current 'shortmess' setting
    local old_shortmess = vim.o.shortmess
    -- Add 's' to shortmess to suppress the written message
    vim.o.shortmess = old_shortmess .. 's'
    -- Set up a one-time autocmd to restore the original shortmess
    vim.api.nvim_create_autocmd('BufWritePost', {
      buffer = vim.fn.bufnr(),
      once = true, -- Execute only once
      callback = function()
        vim.o.shortmess = old_shortmess
      end,
    })
  end,
})

-- Your existing BufWritePost autocmd for fidget notification
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    local filename = vim.fn.expand '%:t'
    vim.notify('Saved ' .. filename, vim.log.levels.INFO, {
      title = 'File Saved',
      icon = '💾',
    })
  end,
})
