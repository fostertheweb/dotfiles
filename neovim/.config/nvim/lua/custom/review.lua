-- PR Review Module
-- Handles rendering PR details with virtual text formatting

local M = {}

local function setup_pr_highlights()
  local highlights = {
    -- Core PR elements
    { 'PRTitle', { fg = '#ffffff', bold = true } },
    { 'PRNumber', { fg = '#8b949e', italic = true } },
    { 'PRState', { fg = '#238636', bold = true } },
    { 'PRStateClosed', { fg = '#da3633', bold = true } },
    { 'PRStateDraft', { fg = '#8b949e', bold = true } },

    -- User/assignee bubbles
    { 'PRUser', { fg = '#ffffff', bg = '#21262d', bold = true } },
    { 'PRUserBorder', { fg = '#30363d' } },

    -- Labels
    { 'PRLabel', { fg = '#ffffff', bg = '#1f6feb', bold = true } },
    { 'PRLabelBorder', { fg = '#388bfd' } },

    -- Stats and metadata
    { 'PRStats', { fg = '#8b949e' } },
    { 'PRStatsGreen', { fg = '#238636' } },
    { 'PRStatsRed', { fg = '#da3633' } },

    -- Section headers
    { 'PRSection', { fg = '#f0f6fc', bold = true } },

    -- Description and body text
    { 'PRBody', { fg = '#e6edf3' } },
    { 'PRBodyDim', { fg = '#8b949e' } },

    -- Timeline elements
    { 'PRTimeline', { fg = '#656d76' } },
    { 'PRTimelineIcon', { fg = '#8b949e' } },
  }

  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl[1], hl[2])
  end
end

-- Utility functions for creating bubble elements
local function create_bubble(text, hl_group, border_hl)
  return {
    { '  ', border_hl or hl_group },
    { text, hl_group },
    { '  ', border_hl or hl_group },
  }
end

local function create_user_bubble(username)
  return create_bubble('@' .. username, 'PRUser', 'PRUserBorder')
end

local function create_label_bubble(label)
  return create_bubble(label, 'PRLabel', 'PRLabelBorder')
end

local function create_stats_text(additions, deletions)
  return {
    { '+' .. additions, 'PRStatsGreen' },
    { ' ', 'PRStats' },
    { '-' .. deletions, 'PRStatsRed' },
  }
end

M.setup = function()
  vim.api.nvim_create_user_command('PRReview', function()
    vim.notify('PR Review', vim.log.levels.INFO)

    -- Set up highlights
    setup_pr_highlights()

    -- Refresh gitsigns first to ensure it detects the worktree properly
    -- vim.cmd 'Gitsigns refresh'

    -- Chain the operations with delays to avoid race conditions
    vim.cmd 'Gitsigns change_base origin/HEAD'

    vim.cmd 'Gitsigns toggle_linehl true'
    vim.cmd 'Gitsigns toggle_deleted true'
    vim.cmd 'Gitsigns toggle_word_diff true'
  end, {})

  -- Auto-enable PR review mode for git-tracked files with changes in worktrees
  vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
      -- Check if we're in a git worktree (has .git file, not directory)
      if vim.fn.filereadable '.git' == 1 then
        local bufname = vim.api.nvim_buf_get_name(0)
        -- Skip if buffer is not a regular file or is a special buffer type
        if bufname == '' or vim.bo.buftype ~= '' then
          return
        end

        -- Check if the file has changes using git diff
        local cmd = 'git diff --name-only origin/HEAD | grep -Fx ' .. vim.fn.shellescape(vim.fn.fnamemodify(bufname, ':~:.'), 1)
        local result = vim.fn.system(cmd)

        -- Only enable PRReview if the file has changes
        if vim.v.shell_error == 0 and result:match '%S' then
          vim.defer_fn(function()
            vim.cmd 'PRReview'
          end, 500)
        end
      end
    end,
  })

  -- Detect PR files
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = '*.pr',
    callback = function()
      vim.bo.filetype = 'pr'
    end,
  })

  -- Set PR files to use markdown rendering
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'pr',
    callback = function()
      vim.wo.wrap = true
      vim.wo.linebreak = true
    end,
  })
end

-- Render PR details from JSON data
function M.render_pr(pr_number)
  local pr_file = '/tmp/pr-' .. pr_number .. '-info.json'
  if vim.fn.filereadable(pr_file) == 0 then
    error('PR info file not found: ' .. pr_file)
  end

  -- Read the entire file and join lines to preserve JSON structure
  local json_lines = vim.fn.readfile(pr_file)
  local json_str = table.concat(json_lines, '\n')
  local json = vim.fn.json_decode(json_str)

  -- Set up highlights
  setup_pr_highlights()

  -- Create temporary file buffer
  local temp_file = '/tmp/pr-' .. json.number .. '.pr'
  vim.cmd('edit ' .. temp_file)
  vim.bo.filetype = 'pullrequest'
  local ns = vim.api.nvim_create_namespace 'pr_virtual_text'

  -- Build content with proper line tracking
  local lines = {}
  local line_map = {} -- Track what each line represents

  -- Line 0: PR number and title
  local title_line = string.format('PR #%d: %s', json.number, json.title)
  table.insert(lines, title_line)
  line_map[#lines] = { type = 'title', data = json }

  -- Line 1: Author
  local author_line = string.format('@%s', json.author.login)
  table.insert(lines, author_line)
  line_map[#lines] = { type = 'author', data = json.author }

  -- Line 2: Stats
  local stats_line = string.format('+%d -%d', json.additions, json.deletions)
  table.insert(lines, stats_line)
  line_map[#lines] = { type = 'stats', data = { additions = json.additions, deletions = json.deletions } }

  -- Line 3: Empty
  table.insert(lines, '')

  -- Line 4: Description header
  table.insert(lines, 'Description')
  line_map[#lines] = { type = 'section_header', text = 'Description' }

  -- Description content
  local body = json.body or 'No description provided'
  if body ~= vim.NIL and body ~= '' then
    for line in body:gmatch '[^\r\n]+' do
      table.insert(lines, line)
      line_map[#lines] = { type = 'description' }
    end
  else
    table.insert(lines, 'No description provided')
    line_map[#lines] = { type = 'description' }
  end

  -- Empty line
  table.insert(lines, '')

  -- Files header
  local files_header = string.format('Files Changed (%d)', #json.files)
  table.insert(lines, files_header)
  line_map[#lines] = { type = 'section_header', text = files_header }

  -- File list
  for _, file in ipairs(json.files) do
    table.insert(lines, file.path)
    line_map[#lines] = { type = 'file', data = file }
  end

  -- Empty line and URL
  table.insert(lines, '')
  table.insert(lines, json.url)
  line_map[#lines] = { type = 'url', data = json.url }

  -- Set buffer content
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Apply virtual text formatting immediately (no vim.schedule)
  for line_idx, line_info in pairs(line_map) do
    local zero_indexed = line_idx - 1 -- Convert to 0-indexed for extmarks

    if line_info.type == 'title' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { title_line, 'PRTitle' } },
        virt_text_pos = 'overlay',
      })
    elseif line_info.type == 'author' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { '  ' .. author_line .. '  ', 'PRUser' } },
        virt_text_pos = 'overlay',
      })
    elseif line_info.type == 'stats' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = {
          { '+' .. line_info.data.additions, 'PRStatsGreen' },
          { ' -' .. line_info.data.deletions, 'PRStatsRed' },
        },
        virt_text_pos = 'overlay',
      })
    elseif line_info.type == 'section_header' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { line_info.text, 'PRSection' } },
        virt_text_pos = 'overlay',
      })
    elseif line_info.type == 'file' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { line_info.data.path, 'PRFile' } },
        virt_text_pos = 'overlay',
      })
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = {
          { ' +' .. line_info.data.additions, 'PRStatsGreen' },
          { ' -' .. line_info.data.deletions, 'PRStatsRed' },
        },
        virt_text_pos = 'eol',
      })
    elseif line_info.type == 'url' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { line_info.data, 'PRLabel' } },
        virt_text_pos = 'overlay',
      })
    end
  end

  -- Save and set as readonly
  vim.cmd 'write'
  vim.bo.modified = false
  vim.bo.readonly = true
end

return M
