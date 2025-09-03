return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },
    }

    local function has_config_file()
      local ft = vim.bo.filetype
      local config_files = {
        '.eslintrc.js',
        '.eslintrc.json',
        '.eslintrc.yml',
        '.eslintrc.yaml',
        'eslint.config.js',
        'eslint.config.mjs',
        '.markdownlint.json',
        '.markdownlint.jsonc',
        '.markdownlint.yaml',
        '.markdownlint.yml',
        '.markdownlintrc',
      }

      local cwd = vim.fn.getcwd()
      for _, file in ipairs(config_files) do
        if vim.fn.filereadable(cwd .. '/' .. file) == 1 then
          return true
        end
      end

      return false
    end

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        if vim.opt_local.modifiable:get() and has_config_file() then
          lint.try_lint()
        end
      end,
    })
  end,
}
