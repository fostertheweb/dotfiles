return {
  {
    'Mofiqul/adwaita.nvim',
    config = function()
      vim.g.adwaita_darker = true
      vim.g.adwaita_disable_cursorline = false
      vim.g.adwaita_transparent = false
    end,
  },
  'ficcdaf/ashen.nvim',
  { 'Koalhack/darcubox-nvim', laze = false, priority = 1000 },
  {
    'lucasadelino/conifer.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      transparent = false,
    },
  },
  'thallada/farout.nvim',
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    },
  },
  'savq/melange-nvim',
  'nyoom-engineering/oxocarbon.nvim',
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  'sainnhe/sonokai',
  'vague2k/vague.nvim',
  'shoenot/witchesbrew.nvim',
}
