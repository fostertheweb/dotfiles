local setup_tig_status = function()
  require('tui').setup {
    name = 'TigOpenStatus',
    command = 'tig status',
    width_margin = 1.5,
    height_margin = 2,
    border = 'rounded',
  }
end

local setup_tig_log = function()
  require('tui').setup {
    name = 'TigOpenLog',
    command = 'tig',
    width_margin = 1.5,
    height_margin = 2,
    border = 'rounded',
  }
end

return {
  {
    'ezechukwu69/tui.nvim',
    config = function()
      setup_tig_status()
      setup_tig_log()
    end,
  },
}
