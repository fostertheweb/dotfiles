return {
  {
    'sudo-tee/opencode.nvim',
    cond = not vim.g.vscode,
    config = function()
      require('opencode').setup {
        preferred_picker = 'snacks',
        default_global_keymaps = false,
        keymap = {
          window = {
            next_message = ']]',
            prev_message = '[[',
            prev_prompt_history = '<up>',
            next_prompt_history = '<down>',
            submit = '<C-j>',
            submit_insert = '<C-j>',
            switch_mode = '<C-s>',
          },
        },
      }

      vim.keymap.set('n', '<leader>oo', require('opencode.api').toggle, { desc = 'Toggle' })
      vim.keymap.set('n', '<leader>os', require('opencode.api').select_session, { desc = 'Sessions' })
      vim.keymap.set('n', '<leader>od', require('opencode.api').diff_open, { desc = 'Diff' })
      -- revert all last promopt

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'opencode_input', 'opencode_output' },
        callback = function()
          vim.keymap.set('n', 'gd', require('opencode.api').diff_open, { desc = 'Diff' })
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'opencode_diff' },
        callback = function()
          -- ]c [c kemaps for next/prev diff
          -- revert this files
        end,
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    cond = not vim.g.vscode,
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
