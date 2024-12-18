return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    require('snacks').setup {
      gitbrowse = { enabled = true },
    }

    vim.keymap.set('n', '<leader>gwf', function()
      local branch = vim.fn.system 'git branch --show-current 2>/dev/null'
      local line_number = vim.api.nvim_win_get_cursor(0)[1]
      Snacks.gitbrowse.open {
        what = 'file',
        branch = branch:match '^%s*(.-)%s*$',
        line_count = line_number,
      }
    end, { desc = 'GitHub file' })

    vim.keymap.set('n', '<leader>gwc', function()
      local git_root = vim.fn.system 'git rev-parse --show-toplevel'
      local file_path = vim.api.nvim_buf_get_name(0)
      local relative_path = string.gsub(file_path, git_root .. '/', '')
      local line_number = vim.api.nvim_win_get_cursor(0)[1]
      local command = string.format('git blame --abbrev=40 -L %d,%d %s', line_number, line_number, relative_path)
      local commit = vim.fn.system(command)
      local hash = vim.fn.system('cut -d" " -f1', commit)
      local url = vim.fn.system('gh pr list --state=merged --json url --jq ".[0].url" --search=' .. hash)

      if #url == 0 then
        vim.notify('No pull requests containing SHA: ' .. hash)
      else
        local commit_url = string.gsub(url, '^%s*(.-)%s*$', '%1') .. '/commits/' .. hash
        vim.notify('Commit URL: ' .. commit_url)
        vim.fn.system('open ' .. commit_url)
      end
    end, { desc = 'GitHub commit' })
  end,
}
