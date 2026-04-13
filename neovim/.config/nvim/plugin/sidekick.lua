local utils = require 'utils'
local default_agent = utils.is_work_computer() and 'claude' or 'pi'

vim.pack.add {
  'https://github.com/folke/sidekick.nvim',
}

require('sidekick').setup {
  cli = {
    picker = 'snacks',
    tools = {
      amp = { cmd = { 'amp' }, url = 'https://ampcode.com/' },
      pi = { cmd = { 'pi' }, url = 'https://pi.dev/' },
    },
  },
  nes = {
    enabled = false,
  },
}

vim.keymap.set({ 'n', 't', 'i', 'x' }, '<C-.>', function()
  require('sidekick.cli').toggle {
    name = default_agent,
    focus = true,
  }
end, { desc = 'Sidekick toggle' })

vim.keymap.set({ 'n', 'x' }, '<leader>at', function()
  require('sidekick.cli').send {
    name = default_agent,
    msg = '{this}',
  }
end, { desc = 'This' })

vim.keymap.set('n', '<leader>af', function()
  require('sidekick.cli').send {
    name = default_agent,
    msg = '{file}',
  }
end, { desc = 'File' })

vim.keymap.set('x', '<leader>av', function()
  require('sidekick.cli').send {
    name = default_agent,
    msg = '{selection}',
  }
end, { desc = 'Selection' })

vim.keymap.set({ 'n', 'x' }, '<leader>ap', function()
  require('sidekick.cli').prompt {
    name = default_agent,
  }
end, { desc = 'Prompt' })
