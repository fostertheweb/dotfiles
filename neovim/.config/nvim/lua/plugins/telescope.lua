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

    -- Keymaps
    local builtin = require 'telescope.builtin'
    -- D, Diagnostics
    vim.keymap.set('n', '<leader>df', builtin.diagnostics, { desc = 'Find' })
    -- F, Find: Files
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Files' })
    vim.keymap.set('n', '<leader>fp', builtin.git_files, { desc = 'Project files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Current word' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Buffers' })
    -- F, Find: LSP
    vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, { desc = 'Type definition' })
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'References' })
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Symbols' })
    vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementations' })
    -- F, Find: Extras
    vim.keymap.set('n', '<C-/>', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_ivy {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Current buffer fuzzy' })
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Neovim files' })
    -- G, Git commands
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Branches' })
    -- H, Help
    vim.keymap.set('n', '<leader>hf', builtin.help_tags, { desc = 'Find' })
    vim.keymap.set('n', '<leader>hk', builtin.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>ht', builtin.builtin, { desc = 'Telescope' })
    -- U, Undo tree
    vim.keymap.set('n', '<leader>u', '<CMD>Telescope undo<CR>', { desc = 'Undo tree' })

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'undo')
  end,
}
