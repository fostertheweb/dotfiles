return {
  'mfussenegger/nvim-lint',
  cond = not vim.g.vscode,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      javascript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      svelte = { 'eslint' },
    }

    lint.linters_by_ft['clojure'] = nil
    lint.linters_by_ft['inko'] = nil
    lint.linters_by_ft['janet'] = nil
    lint.linters_by_ft['rst'] = nil
    lint.linters_by_ft['terraform'] = nil

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        if vim.opt_local.modifiable:get() then
          lint.try_lint()
        end
      end,
    })
  end,
}
