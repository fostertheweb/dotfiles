return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    -- Two important keymaps to use while in telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    local actions = require 'telescope.actions'
    require('telescope').setup {
      defaults = {
        layout_config = {
          horizontal = { height = 0.5 },
          prompt_position = 'top',
          vertical = {
            preview_cutoff = 1,
            preview_height = 0.65,
            mirror = true,
            width = 0.55,
          },
        },
        layout_strategy = 'vertical',
        sorting_strategy = 'ascending',
        mappings = {
          i = { ['<C-j>'] = actions.select_default },
        },
      },
      pickers = {
        find_files = {
          theme = 'ivy',
          hidden = true,
        },
        git_files = {
          theme = 'ivy',
          show_untracked = true,
        },
        grep_string = {
          theme = 'ivy',
          additional_args = { '--hidden' },
        },
        live_grep = {
          theme = 'ivy',
          additional_args = { '--hidden' },
        },
      },
      extensions = {
        fzf = {},
        ['ui-select'] = {
          require('telescope.themes').get_cursor(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'undo')
  end,
}
