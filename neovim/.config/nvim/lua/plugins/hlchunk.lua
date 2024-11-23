return {
  'ediezindell/hlchunk.nvim',
  commit = "370514d5e6de606bf5e6fa6f29b228994a90f797",
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup {
      chunk = {
        enable = true,
      },
    }
  end,
}
