local is_inside_work_tree = {}

return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    enabled = true,
    opts = {},
    config = function()
      local fzf = require 'fzf-lua'
      fzf.setup {
        defaults = {
          formatter = 'path.filename_first',
        },
        file_icon_padding = ' ',
        grep = {
          hidden = true,
        },
        winopts = {
          backdrop = 90,
          preview = {
            hidden = true,
          },
        },
        keymap = {
          builtin = {
            ['<C-k>'] = 'kill-line',
            ['<C-l>'] = 'toggle-preview',
          },
          fzf = {
            ['ctrl-k'] = 'kill-line',
            ['ctrl-l'] = 'toggle-preview',
          },
        },
      }

      vim.api.nvim_create_user_command('ProjectFiles', fzf.files, {})

      -- Space
      vim.keymap.set('n', '<leader>f<leader>', fzf.resume, { desc = 'Rerun previous' })
      -- D, Diagnostics
      vim.keymap.set('n', '<leader>df', fzf.diagnostics_workspace, { desc = 'Find' })
      -- F, Find: Files
      vim.keymap.set('n', '<leader>ff', function()
        fzf.files { resume = true }
      end, { desc = 'All files' })
      vim.keymap.set('n', '<leader>p', fzf.files, { desc = 'Project files' })
      vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Grep' })
      vim.keymap.set('n', '<leader>fw', fzf.grep_cword, { desc = 'Current word' })
      vim.keymap.set('n', '<leader>f.', fzf.oldfiles, { desc = 'Recent files' })
      -- F, Find: LSP
      vim.keymap.set('n', '<leader>ft', fzf.lsp_typedefs, { desc = 'Type definition' })
      vim.keymap.set('n', '<leader>fr', fzf.lsp_references, { desc = 'References' })
      vim.keymap.set('n', '<leader>fs', fzf.lsp_document_symbols, { desc = 'Symbols' })
      vim.keymap.set('n', '<leader>fi', fzf.lsp_implementations, { desc = 'Implementations' })
      -- Buffer search
      vim.keymap.set('n', '<leader>/', function()
        fzf.lgrep_curbuf()
      end, { desc = 'Current buffer fuzzy' })
      -- G, Git commands
      vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = 'Branches' })
      -- H, Help
      vim.keymap.set('n', '<leader>hf', fzf.helptags, { desc = 'Find' })
      vim.keymap.set('n', '<leader>hk', fzf.keymaps, { desc = 'Keymaps' })
      vim.keymap.set('n', '<leader>hp', fzf.builtin, { desc = 'Pickers' })
    end,
  },
}
