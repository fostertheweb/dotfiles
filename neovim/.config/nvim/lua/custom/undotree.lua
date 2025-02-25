-- undo-history.lua
-- A Neovim plugin to show undo history in a floating window with diff view

local M = {}
local api = vim.api
local fn = vim.fn

-- Configuration with defaults
M.config = {
  window = {
    width = 80,
    height = 20,
    border = 'rounded',
  },
  mappings = {
    next = 'j',
    prev = 'k',
    revert = 'r',
    copy = 'y',
    close = 'q',
  },
  diff_opts = {
    internal = true,
    vertical = false,
  },
}

-- State variables
local state = {
  buf = nil, -- Buffer for the undo history window
  win = nil, -- Window ID for the floating window
  current_buf = nil, -- Original buffer being viewed
  undo_entries = {}, -- List of undo entries
  current_idx = 0, -- Current position in undo history
  preview_buf = nil, -- Buffer for preview
  preview_win = nil, -- Window for preview
}

-- Get undo history for the current buffer
local function get_undo_history()
  local undo_entries = {}
  local undo_info = fn.undotree()

  if not undo_info or not undo_info.entries or #undo_info.entries == 0 then
    return {}
  end

  -- Process entries to make them easier to navigate
  for _, entry in ipairs(undo_info.entries) do
    table.insert(undo_entries, {
      seq = entry.seq,
      time = entry.time,
      alt = entry.alt or {},
      saved = entry.save or 0,
      curhead = entry.curhead == 1,
    })
  end

  -- Sort by sequence number
  table.sort(undo_entries, function(a, b)
    return a.seq > b.seq
  end)

  return undo_entries
end

-- Format time delta for display
local function format_time_delta(timestamp)
  local now = os.time()
  local delta = now - timestamp

  if delta < 60 then
    return delta .. 's ago'
  elseif delta < 3600 then
    return math.floor(delta / 60) .. 'm ago'
  elseif delta < 86400 then
    return math.floor(delta / 3600) .. 'h ago'
  else
    return math.floor(delta / 86400) .. 'd ago'
  end
end

-- Render the undo history in the buffer
local function render_undo_history()
  local lines = {}

  if #state.undo_entries == 0 then
    table.insert(lines, 'No undo history available')
    api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
    return
  end

  table.insert(lines, 'Undo History (q:close, j/k:navigate, r:revert, y:copy)')
  table.insert(lines, string.rep('─', M.config.window.width - 2))

  for idx, entry in ipairs(state.undo_entries) do
    local prefix = '  '
    if idx == state.current_idx then
      prefix = '> '
    elseif entry.curhead then
      prefix = '* '
    end

    local line = string.format('%s#%d (%s)%s', prefix, entry.seq, format_time_delta(entry.time), entry.saved > 0 and ' [saved]' or '')

    table.insert(lines, line)
  end

  api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)

  -- Highlight the current selection
  if state.current_idx > 0 then
    api.nvim_buf_add_highlight(state.buf, -1, 'PmenuSel', state.current_idx + 1, 0, -1)
  end
end

-- Show diff between current state and selected undo entry
local function show_diff()
  -- Clear any existing preview
  if state.preview_win and api.nvim_win_is_valid(state.preview_win) then
    api.nvim_win_close(state.preview_win, true)
  end

  if state.preview_buf and api.nvim_buf_is_valid(state.preview_buf) then
    api.nvim_buf_delete(state.preview_buf, { force = true })
  end

  if state.current_idx == 0 or #state.undo_entries == 0 then
    return
  end

  -- Create preview buffer
  state.preview_buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(state.preview_buf, 'bufhidden', 'wipe')

  -- Save current state to restore later
  local current_pos = api.nvim_win_get_cursor(0)
  local current_undo_seq = fn.undotree().seq_cur

  -- Go to the selected undo state
  local target_seq = state.undo_entries[state.current_idx].seq
  api.nvim_command('silent undo ' .. target_seq)

  -- Copy content to preview buffer
  local lines = api.nvim_buf_get_lines(state.current_buf, 0, -1, false)
  api.nvim_buf_set_lines(state.preview_buf, 0, -1, false, lines)

  -- Return to original state
  api.nvim_command('silent undo ' .. current_undo_seq)
  api.nvim_win_set_cursor(0, current_pos)

  -- Calculate preview window size and position
  local win_width = api.nvim_win_get_width(state.win)
  local win_height = api.nvim_win_get_height(state.win)
  local win_row = api.nvim_win_get_position(state.win)[1]
  local win_col = api.nvim_win_get_position(state.win)[2]

  local preview_width = math.floor(M.config.window.width * 1.2)
  local preview_height = math.floor(M.config.window.height * 0.8)

  -- Create preview window
  state.preview_win = api.nvim_open_win(state.preview_buf, false, {
    relative = 'editor',
    row = win_row + 3,
    col = win_col + win_width + 2,
    width = preview_width,
    height = preview_height,
    border = M.config.window.border,
    style = 'minimal',
  })

  -- Set buffer options for syntax highlighting
  local filetype = api.nvim_buf_get_option(state.current_buf, 'filetype')
  api.nvim_buf_set_option(state.preview_buf, 'filetype', filetype)

  -- Add header to buffer
  api.nvim_buf_set_lines(state.preview_buf, 0, 0, false, {
    'Preview of change #' .. target_seq,
    string.rep('─', preview_width - 2),
  })

  return state.preview_buf, state.preview_win
end

-- Apply the selected undo entry
local function apply_undo()
  if state.current_idx == 0 or #state.undo_entries == 0 then
    return
  end

  local target_seq = state.undo_entries[state.current_idx].seq
  M.close()

  -- Go to the selected state
  api.nvim_command('silent undo ' .. target_seq)

  -- Show notification
  vim.notify('Reverted to change #' .. target_seq, vim.log.levels.INFO)
end

-- Copy changes from the selected undo entry
local function copy_changes()
  if state.current_idx == 0 or #state.undo_entries == 0 then
    return
  end

  -- Save current state to restore later
  local current_pos = api.nvim_win_get_cursor(0)
  local current_undo_seq = fn.undotree().seq_cur

  -- Go to the selected undo state
  local target_seq = state.undo_entries[state.current_idx].seq
  api.nvim_command('silent undo ' .. target_seq)

  -- Copy content to register
  local lines = api.nvim_buf_get_lines(state.current_buf, 0, -1, false)
  vim.fn.setreg('"', table.concat(lines, '\n'))

  -- Return to original state
  api.nvim_command('silent undo ' .. current_undo_seq)
  api.nvim_win_set_cursor(0, current_pos)

  -- Close the history view
  M.close()

  -- Show notification
  vim.notify('Copied content from change #' .. target_seq, vim.log.levels.INFO)
end

-- Navigate to next item in history
local function next_entry()
  if state.current_idx < #state.undo_entries then
    state.current_idx = state.current_idx + 1
    render_undo_history()
    show_diff()
  end
end

-- Navigate to previous item in history
local function prev_entry()
  if state.current_idx > 1 then
    state.current_idx = state.current_idx - 1
    render_undo_history()
    show_diff()
  end
end

-- Close the undo history window
function M.close()
  if state.preview_win and api.nvim_win_is_valid(state.preview_win) then
    api.nvim_win_close(state.preview_win, true)
  end

  if state.preview_buf and api.nvim_buf_is_valid(state.preview_buf) then
    api.nvim_buf_delete(state.preview_buf, { force = true })
  end

  if state.win and api.nvim_win_is_valid(state.win) then
    api.nvim_win_close(state.win, true)
  end

  if state.buf and api.nvim_buf_is_valid(state.buf) then
    api.nvim_buf_delete(state.buf, { force = true })
  end

  state.buf = nil
  state.win = nil
  state.preview_buf = nil
  state.preview_win = nil
  state.undo_entries = {}
  state.current_idx = 0
end

-- Setup keymaps for the undo history buffer
local function setup_keymaps()
  local function map(key, action)
    api.nvim_buf_set_keymap(state.buf, 'n', key, '', {
      noremap = true,
      silent = true,
      callback = action,
    })
  end

  map(M.config.mappings.next, next_entry)
  map(M.config.mappings.prev, prev_entry)
  map(M.config.mappings.revert, apply_undo)
  map(M.config.mappings.copy, copy_changes)
  map(M.config.mappings.close, M.close)
end

-- Open the undo history window
function M.open()
  -- Get current buffer
  state.current_buf = api.nvim_get_current_buf()

  -- Get undo history
  state.undo_entries = get_undo_history()

  if #state.undo_entries == 0 then
    vim.notify('No undo history available', vim.log.levels.WARN)
    return
  end

  -- Set initial position to latest entry
  state.current_idx = 1

  -- Create buffer for undo history
  state.buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(state.buf, 'bufhidden', 'wipe')
  api.nvim_buf_set_option(state.buf, 'filetype', 'UndoHistory')

  -- Calculate window position
  local win_width = api.nvim_get_option 'columns'
  local win_height = api.nvim_get_option 'lines'

  local width = math.min(win_width - 4, M.config.window.width)
  local height = math.min(win_height - 4, M.config.window.height)

  local row = math.floor((win_height - height) / 2)
  local col = math.floor((win_width - width) / 2)

  -- Create floating window
  state.win = api.nvim_open_win(state.buf, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    border = M.config.window.border,
    style = 'minimal',
  })

  -- Render the undo history
  render_undo_history()

  -- Show diff of current entry
  show_diff()

  -- Setup keymaps
  setup_keymaps()

  -- Set window options
  api.nvim_win_set_option(state.win, 'winblend', 0)
  api.nvim_win_set_option(state.win, 'cursorline', true)

  -- Set buffer options
  api.nvim_buf_set_option(state.buf, 'modifiable', false)
  api.nvim_buf_set_option(state.buf, 'swapfile', false)
end

-- Setup function
function M.setup(opts)
  -- Merge user config with defaults
  if opts then
    M.config = vim.tbl_deep_extend('force', M.config, opts)
  end

  -- Create user command
  api.nvim_create_user_command('UndoHistory', M.open, {})

  -- Return the module for chaining
  return M
end

return M
