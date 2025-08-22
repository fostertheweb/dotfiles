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
  { 'aliqyan-21/darkvoid.nvim', lazy = false, priority = 1000 },
  {
    'thallada/farout.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { 'savq/melange-nvim' },
  { 'vague2k/vague.nvim', opts = {} },
  {
    'shoenot/witchesbrew.nvim',
    priority = 1000,
  },
}
