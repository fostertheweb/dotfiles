return {
  {
    'Mofiqul/adwaita.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.adwaita_darker = true
      vim.g.adwaita_disable_cursorline = false
      vim.g.adwaita_transparent = false
    end,
  },
  {
    'ficcdaf/ashen.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'Koalhack/darcubox-nvim' },
  {
    'timmypidashev/darkbox.nvim',
    lazy = false,
    config = function()
      require('darkbox').load()
    end,
  },
  { 'aliqyan-21/darkvoid.nvim', lazy = false, priority = 1000 },
  {
    'thallada/farout.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'savq/melange-nvim' },
  { 'vague2k/vague.nvim', opts = {} },
  { 'S-Spektrum-M/odyssey.nvim' },
  'abreujp/scholar.nvim',
  {
    'shoenot/witchesbrew.nvim',
    priority = 1000,
  },
}
