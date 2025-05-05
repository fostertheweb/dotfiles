local utils = require 'utils'

-- Emacs style insert mode movement
local imap = function(keys, fn, desc)
  vim.keymap.set('i', keys, function()
    fn()
  end, { desc = desc })
end

imap('<C-a>', utils.move_to_start_of_line, 'Go to line start')
imap('<C-e>', utils.move_to_end_of_line, 'Go to line end')
imap('<C-f>', utils.move_forward, 'Go forward')
imap('<C-b>', utils.move_backward, 'Go backward')
imap('<C-k>', utils.cut, 'Cut to line end')
imap('<C-y>', function()
  utils.paste()
end, 'Yank from " register')
