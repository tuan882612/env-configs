local plugins = {
  -- Mason and LSP
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    opts = { ensure_installed = { 
        "gopls", "ruff", "clangd", "rust_analyzer", "pyright", "zls",
      } 
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = { "go", "python", "rust", "c", "cpp", "java", "zig" },
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = function()
      return require "custom.configs.conform"
    end,
    event = "BufWritePre",
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = { accept = "<C-J>" },
        },
        panel = {
          enabled = true,
          keymap = { open = "<C-P>" },
        },
      }
    end,
  },

  -- UI Plugins
  { "tribela/vim-transparent" },
}

return plugins
