return {
  {
    'yetone/avante.nvim',
    build = 'make',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'echasnovski/mini.pick', -- for file_selector provider mini.pick
      'folke/snacks.nvim', -- for input provider snacks
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
    },
    opts = {
      provider = 'copilot',
      providers = {
        copilot = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-sonnet-4-20250514',
        },
      },
    },
  },
  {
    'zbirenbaum/copilot.lua',
    config = function()
      require('copilot').setup {
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
        },
      }
    end,
  },
  {
    'dlants/magenta.nvim',
    enabled = false,
    lazy = false, -- you could also bind to <leader>mt
    build = 'npm install --frozen-lockfile',
    opts = {
      profiles = {
        {
          name = 'copilot-claude',
          provider = 'copilot',
          model = 'claude-sonnet-4',
        },
      },
    },
  },
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
    config = function()
      require('mcphub').setup()
    end,
  },
  {
    'NickvanDyke/opencode.nvim',
    enabled = false,
    dependencies = { 'folke/snacks.nvim' },
    opts = {
      auto_reload = true,
      terminal = {
        win = {
          enter = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { '<leader>oa', function() require('opencode').ask() end, desc = 'Ask opencode', mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>op', function() require('opencode').select_prompt() end, desc = 'Select prompt', mode = { 'n', 'v', }, },
      { '<leader>on', function() require('opencode').command('session_new') end, desc = 'New session', },
      { '<leader>oy', function() require('opencode').command('messages_copy') end, desc = 'Copy last message', },
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    config = function()
      require('supermaven-nvim').setup {
        ignore_filetypes = { 'opencode_input' },
        keymaps = {
          accept_suggestion = '<C-f>',
          clear_suggestion = '<C-k>',
          accept_word = '<C-l>',
        },
      }
    end,
  },
}
