local setup_tui = function(name, command)
  require('tui').setup {
    name = name,
    command = command,
    width_margin = 1.5,
    height_margin = 2,
    border = 'rounded',
  }
end

return {
  {
    'ezechukwu69/tui.nvim',
    config = function()
      setup_tui('TigOpenStatus', 'tig status')
      setup_tui('TigOpenCommits', 'tig')
      setup_tui('BtopOpen', 'btop')
      setup_tui('PostingOpen', 'posting')
    end,
  },
}
