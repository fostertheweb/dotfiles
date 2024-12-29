local setup_tig = function()
  require('tui').setup {
    name = 'TigOpen',
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
    setup_tig()
    setup_serie()
  end,
  keys = {
    { '<leader>ot', '<cmd>TigOpen<cr>', desc = 'Open tig' },
    { '<leader>og', '<cmd>GituOpen<cr>', desc = 'Open gitu' },
    { '<leader>os', '<cmd>SerieOpen<cr>', desc = 'Open serie' },
  },
}
