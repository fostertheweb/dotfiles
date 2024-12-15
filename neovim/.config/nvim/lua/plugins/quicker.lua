-- TODO
-- Ctrl-j to accept
-- Ctrl-q o copen
-- Ctrl-q n cnext
-- Ctrl-q p cprev
return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  opts = {
    buflisted = false,
    number = false,
    relativenumber = false,
    signcolumn = 'auto',
    winfixheight = true,
    wrap = false,
    borders = {
      vert = '|',
    },
  },
}
