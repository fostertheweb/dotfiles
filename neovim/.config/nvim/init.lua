-- Keybindings
local keymap = vim.api.nvim_set_keymap

keymap("i", "jj", "<Esc>", {})
keymap("n", "<C-p>", ":Telescope git_files<CR>", {})
keymap("n", "<C-f>", ":Telescope live_grep<CR>", {})
keymap("n", "<C-t>", ":Telescope lsp_document_symbols<CR>", {})
keymap("n", "<C-b>", ":Telescope buffers<CR>", {})
keymap("n", "<C-o>", ":Lf<CR>", {})

-- Plugins
require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("savq/melange")
  use({
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  })
  use("editorconfig/editorconfig-vim")
  use("kyazdani42/nvim-web-devicons")
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
        },
      })
    end,
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      local telescope = require("telescope")
      telescope.setup()
      telescope.load_extension("fzf")
      telescope.load_extension("projects")
    end,
  })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "lua",
          "rust",
          "c_sharp",
          "dockerfile",
          "fish",
          "go",
          "javascript",
          "typescript",
          "tsx",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  })
  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({})
    end,
  })
  use({
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.sumneko_lua.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.cssls.setup({})
      lspconfig.tailwindcss.setup({})
      lspconfig.html.setup({})
    end,
  })
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end,
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use:
                -- vim.lsp.buf.format({ bufnr = bufnr })
                vim.lsp.buf.formatting_sync()
              end,
            })
          end
        end,
        sources = {
          require("null-ls").builtins.formatting.stylua,
          require("null-ls").builtins.formatting.prettier,
        },
      })
    end,
  })
  use({
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
    config = function()
      require("toggleterm").setup()
    end,
  })
  use({
    "lmburns/lf.nvim",
    config = function()
      require("lf").setup({
        winblend = 0,
        border = "single",
      })
    end,
    requires = {
      "plenary.nvim",
      "toggleterm.nvim",
    },
  })
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup({
        sources = {
          { name = "nvim_lsp" },
        },
      })

      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

      require("lspconfig").tsserver.setup({
        capabilities = capabilities,
      })
    end,
  })
  use({ "hrsh7th/cmp-nvim-lsp" })
end)

-- Completions

-- Options
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.g.mapleader = "<Space>"

vim.cmd([[colorscheme melange]])

-- Custom
function bg_mode()
  local time = os.date("*t")
  if time.hour > 19 or time.hour < 7 then
    vim.cmd([[set bg=dark]])
  else
    vim.cmd([[set bg=light]])
  end
end

bg_mode()
