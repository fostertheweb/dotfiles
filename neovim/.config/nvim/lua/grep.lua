vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
vim.opt.grepformat = '%f:%l:%c:%m'

vim.keymap.set('n', '<leader>gg', function()
  vim.ui.input({ prompt = 'Grep: ' }, function(pattern)
    if pattern then
      vim.cmd('silent grep! ' .. vim.fn.fnameescape(pattern))
      vim.cmd 'copen'
    end
  end)
end, { desc = 'Grep', silent = true })
