local setup_tig_status = function()
  require('tui').setup {
    name = 'TigOpenStatus',
    command = 'tig status',
    width_margin = 0,
    height_margin = 0.5,
    border = 'none',
  }
end

local setup_tig_log = function()
  require('tui').setup {
    name = 'TigOpenLog',
    command = 'tig',
    width_margin = 0,
    height_margin = 0.5,
    border = 'none',
  }
end

local setup_oterm = function()
  require('tui').setup {
    name = 'OtermOpen',
    command = 'oterm',
    width_margin = 0,
    height_margin = 0.5,
    border = 'none',
  }
end

return {
  'ezechukwu69/tui.nvim',
  config = function()
    setup_tig_status()
    setup_tig_log()
    setup_oterm()
  end,
}
