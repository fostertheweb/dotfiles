return {
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
  'amedoeyes/eyes.nvim',
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
  {
    'Kaikacy/Lemons.nvim',
    version = '*',
    lazy = false,
    priority = 1000,
  },
  'savq/melange-nvim',
  'yorickpeterse/vim-paper',
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  'SebastianZaha/nvim-solar-paper',
  'sainnhe/sonokai',
  'vague2k/vague.nvim',
  'shoenot/witchesbrew.nvim',
}
