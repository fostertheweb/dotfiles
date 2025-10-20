vim.api.nvim_create_user_command('UpdatePath', function()
  if vim.fn.executable 'fd' == 1 then
    local fd_results = vim.fn.systemlist 'fd --type f --hidden --follow --exclude .git'
    local dirs = {}
    for _, file in ipairs(fd_results) do
      local dir = vim.fn.fnamemodify(file, ':h')
      dirs[dir] = true
    end
    local path_list = {}
    for dir, _ in pairs(dirs) do
      table.insert(path_list, dir)
    end
    vim.o.path = table.concat(path_list, ',')
  end
end, {})
