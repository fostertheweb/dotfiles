-- PR Renderer Module
-- Handles rendering PR details with virtual text formatting

local M = {}

-- Set up PR highlight groups
local function setup_pr_highlights()
  local highlights = {
    { 'PRTitle', { fg = '#58a6ff', bold = true } },
    { 'PRNumber', { fg = '#8b949e', italic = true } },
    { 'PRState', { fg = '#238636', bold = true } },
    { 'PRUser', { fg = '#ffffff', bg = '#21262d', bold = true } },
    { 'PRLabel', { fg = '#58a6ff', bold = true } },
    { 'PRStatsGreen', { fg = '#238636', bold = true } },
    { 'PRStatsRed', { fg = '#da3633', bold = true } },
    { 'PRSection', { fg = '#f0f6fc', bold = true } },
    { 'PRFile', { fg = '#e6edf3' } },
  }
  
  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl[1], hl[2])
  end
end

-- Render PR details from JSON data
function M.render_pr(pr_number)
  local pr_file = "/tmp/pr-" .. pr_number .. "-info.json"
  if vim.fn.filereadable(pr_file) == 0 then
    error("PR info file not found: " .. pr_file)
  end
  
  -- Read the entire file and join lines to preserve JSON structure
  local json_lines = vim.fn.readfile(pr_file)
  local json_str = table.concat(json_lines, "\n")
  local json = vim.fn.json_decode(json_str)
  
  -- Set up highlights
  setup_pr_highlights()
  
  -- Create temporary file buffer
  local temp_file = "/tmp/pr-" .. json.number .. ".pr"
  vim.cmd('edit ' .. temp_file)
  vim.bo.filetype = 'pullrequest'
  local ns = vim.api.nvim_create_namespace('pr_virtual_text')
  
  -- Build content with proper line tracking
  local lines = {}
  local line_map = {}  -- Track what each line represents
  
  -- Line 0: PR number and title 
  local title_line = string.format("PR #%d: %s", json.number, json.title)
  table.insert(lines, title_line)
  line_map[#lines] = { type = 'title', data = json }
  
  -- Line 1: Author 
  local author_line = string.format("@%s", json.author.login)
  table.insert(lines, author_line)
  line_map[#lines] = { type = 'author', data = json.author }
  
  -- Line 2: Stats
  local stats_line = string.format("+%d -%d", json.additions, json.deletions)
  table.insert(lines, stats_line)
  line_map[#lines] = { type = 'stats', data = { additions = json.additions, deletions = json.deletions } }
  
  -- Line 3: Empty
  table.insert(lines, "")
  
  -- Line 4: Description header
  table.insert(lines, "Description")
  line_map[#lines] = { type = 'section_header', text = 'Description' }
  
  -- Description content
  local body = json.body or "No description provided"
  if body ~= vim.NIL and body ~= "" then
    for line in body:gmatch("[^\r\n]+") do
      table.insert(lines, line)
      line_map[#lines] = { type = 'description' }
    end
  else
    table.insert(lines, "No description provided")
    line_map[#lines] = { type = 'description' }
  end
  
  -- Empty line
  table.insert(lines, "")
  
  -- Files header
  local files_header = string.format("Files Changed (%d)", #json.files)
  table.insert(lines, files_header)
  line_map[#lines] = { type = 'section_header', text = files_header }
  
  -- File list
  for _, file in ipairs(json.files) do
    table.insert(lines, file.path)
    line_map[#lines] = { type = 'file', data = file }
  end
  
  -- Empty line and URL
  table.insert(lines, "")
  table.insert(lines, json.url)
  line_map[#lines] = { type = 'url', data = json.url }
  
  -- Set buffer content
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  
  -- Apply virtual text formatting immediately (no vim.schedule)
  for line_idx, line_info in pairs(line_map) do
    local zero_indexed = line_idx - 1  -- Convert to 0-indexed for extmarks
    
    if line_info.type == 'title' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { title_line, 'PRTitle' } },
        virt_text_pos = 'overlay'
      })
    elseif line_info.type == 'author' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { '  ' .. author_line .. '  ', 'PRUser' } },
        virt_text_pos = 'overlay'
      })
    elseif line_info.type == 'stats' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = {
          { '+' .. line_info.data.additions, 'PRStatsGreen' },
          { ' -' .. line_info.data.deletions, 'PRStatsRed' }
        },
        virt_text_pos = 'overlay'
      })
    elseif line_info.type == 'section_header' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { line_info.text, 'PRSection' } },
        virt_text_pos = 'overlay'
      })
    elseif line_info.type == 'file' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { line_info.data.path, 'PRFile' } },
        virt_text_pos = 'overlay'
      })
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = {
          { ' +' .. line_info.data.additions, 'PRStatsGreen' },
          { ' -' .. line_info.data.deletions, 'PRStatsRed' }
        },
        virt_text_pos = 'eol'
      })
    elseif line_info.type == 'url' then
      vim.api.nvim_buf_set_extmark(0, ns, zero_indexed, 0, {
        virt_text = { { line_info.data, 'PRLabel' } },
        virt_text_pos = 'overlay'
      })
    end
  end
  
  -- Save and set as readonly
  vim.cmd('write')
  vim.bo.modified = false
  vim.bo.readonly = true
end

return M