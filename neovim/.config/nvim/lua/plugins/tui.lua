local setup_tig_status = function()
  require('tui').setup {
    name = 'TigOpenStatus',
    command = 'tig status',
    width_margin = 0,
    height_margin = 0,
    border = 'none',
  }
end

local setup_tig_log = function()
  require('tui').setup {
    name = 'TigOpenLog',
    command = 'tig',
    width_margin = 0,
    height_margin = 0,
    border = 'none',
  }
end

local setup_gitu = function()
  require('tui').setup {
    name = 'GituOpen',
    command = 'gitu',
    width_margin = 0,
    height_margin = 0,
    border = 'none',
  }
end

local setup_serie = function()
  require('tui').setup {
    name = 'SerieOpen',
    command = 'serie',
    width_margin = 0,
    height_margin = 0,
    border = 'none',
  }
end

return {
  'ezechukwu69/tui.nvim',
  config = function()
    setup_gitu()
    setup_tig_status()
    setup_tig_log()
    setup_serie()
  end,
}
