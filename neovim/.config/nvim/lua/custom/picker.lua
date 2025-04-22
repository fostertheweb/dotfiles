local M = {}

M.get_items = function(picker)
  local items = picker:selected { fallback = true } -- Fallback to the item under the cursor if none are selected
  if #items == 0 then
    local item = picker:current() -- Get the item under the cursor
    if item then
      items = { item }
    end
  end
  if #items == 0 then
    return -- No item selected or under the cursor
  end

  return items
end

M.git_unstage = function(picker)
  local items = M.get_items(picker)

  local done = 0
  for _, item in ipairs(items) do
    local cmd = { 'git', 'restore', '--staged', item.file }
    Snacks.picker.util.cmd(cmd, function(data, code)
      done = done + 1
      if done == #items then
        picker.list:set_selected()
        picker.list:set_target()
        picker:find()
      end
    end, { cwd = item.cwd })
  end
end

M.git_discard = function(picker)
  local items = M.get_items(picker)

  local done = 0
  for _, item in ipairs(items) do
    local cmd = { 'git', 'restore', item.file }
    Snacks.picker.util.cmd(cmd, function(data, code)
      done = done + 1
      if done == #items then
        picker.list:set_selected()
        picker.list:set_target()
        picker:find()
      end
    end, { cwd = item.cwd })
  end
end

return M
