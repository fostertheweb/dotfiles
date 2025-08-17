vim.api.nvim_create_autocmd('TabClosed', {
  desc = 'Tab closed, return to terminal buffer',
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd 'startinsert'
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Terminal buffer appearence',
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd 'startinsert'
  end,
})

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*',
  callback = function()
    vim.schedule(function()
      local bufname = vim.fn.expand '<afile>'
      if vim.bo.buftype == 'terminal' and vim.v.shell_error == 0 and bufname == '' then
        vim.cmd('bdelete! ' .. vim.fn.expand '<abuf>')
      end
    end)
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start commit editor in insert mode',
  pattern = { 'gitcommit', 'gitrebase', 'gitconfig', 'COMMIT_EDITMSG' },
  callback = function(ev)
    vim.bo[ev.buf].bufhidden = 'wipe'
    vim.cmd 'startinsert'
  end,
})
