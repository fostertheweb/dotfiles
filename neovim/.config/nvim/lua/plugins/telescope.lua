local is_inside_work_tree = {}

local project_files = function()
  local opts = {}

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system 'git rev-parse --is-inside-work-tree'
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require('telescope.builtin').git_files(opts)
  else
    require('telescope.builtin').find_files(opts)
  end
end

vim.api.nvim_create_user_command('ProjectFiles', project_files, {})

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'debugloop/telescope-undo.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    require('telescope').setup {
      defaults = vim.tbl_extend('force', require('telescope.themes').get_ivy(), {
        path_display = {
          truncate = 3,
        },
        mappings = {
          i = { ['<C-j>'] = 'select_default' },
        },
      }),
      pickers = {
        buffers = {
          mappings = {
            i = { ['<C-k>'] = 'delete_buffer' },
          },
        },
        find_files = {
          hidden = true,
        },
        git_files = {
          show_untracked = true,
        },
        grep_string = {
          additional_args = { '--hidden' },
        },
        live_grep = {
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
    vim.keymap.set('n', '<leader>fp', project_files, { desc = 'Project files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Current word' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Recent files' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
    -- F, Find: LSP
    vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, { desc = 'Type definition' })
    vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'References' })
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Symbols' })
    vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementations' })
    -- F, Find: Extras
    vim.keymap.set('n', '<C-/>', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
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
