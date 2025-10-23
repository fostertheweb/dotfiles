return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    dependencies = { 'AndreM222/copilot-lualine' },
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
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = false,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup {
        model = 'claude-sonnet-4', -- AI model to use
        temperature = 0.1, -- Lower = focused, higher = creative
        window = {
          layout = 'vertical',
          width = 0.5, -- Fixed width in columns
        },
        headers = {
          user = '👤 You',
          assistant = '🤖 Copilot',
          tool = '🔧 Tool',
        },
        separator = '━━',
        auto_fold = true, -- Automatically folds non-assistant messages
        auto_insert_mode = true, -- Enter insert mode when opening
      }

      vim.keymap.set({ 'n', 'x', 'v', 't' }, '<C-Space>', '<CMD>CopilotChatToggle<CR>', { desc = 'Toggle' })
      vim.keymap.set({ 'n', 'x', 'v', 't' }, '<C-.>', '<CMD>CopilotChatPrompts<CR>', { desc = 'Actions' })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'copilot-chat',
        callback = function(ev)
          vim.keymap.set('i', '<C-Space>', '<CMD>CopilotChatToggle<CR>', { buffer = ev.buf, desc = 'Toggle' })
        end,
      })
    end,
  },
  {
    'ravitemer/mcphub.nvim',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    build = 'npm install -g mcp-hub@latest', -- Installs `mcp-hub` node binary globally
    config = function()
      require('mcphub').setup {
        extensions = {
          copilotchat = {
            enabled = true,
            convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
            convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
            add_mcp_prefix = false, -- Add "mcp_" prefix to function names
          },
        },
      }
    end,
  },
  {
    'folke/sidekick.nvim',
    opts = {},
    keys = {
      {
        '<C-f>',
        function()
          if not require('sidekick').nes_jump_or_apply() then
            return '<C-f>'
          end
        end,
        mode = { 'i', 'n' },
        expr = true,
        desc = 'Accept suggestion',
      },
    },
  },
  {
    'supermaven-inc/supermaven-nvim',
    enabled = false,
    event = {
      'BufReadPost',
      'BufNewFile',
    },
    config = function()
      require('supermaven-nvim').setup {
        ignore_filetypes = { 'copilot-chat' },
        keymaps = {
          accept_suggestion = '<C-f>',
          clear_suggestion = '<C-k>',
          accept_word = '<C-l>',
        },
      }
    end,
  },
}
