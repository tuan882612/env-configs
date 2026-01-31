return {
  {
    "stevearc/conform.nvim",
    lazy = false,
    opts = require "configs.conform",
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Zig Plugin
  { "ziglang/zig.vim" },

  -- Ui Plugin
  {
    "tribela/vim-transparent",
    event = "VimEnter",
  },

  -- Comment Plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end,
  },

  -- Luau Lsp Plugin
  {
    "lopi-py/luau-lsp.nvim",
    ft = { "luau", "lua" },
    config = function()
      require("luau-lsp").setup({
        platform = { type = "roblox" }, -- enables Roblox environment/types
        types = {
          roblox_security_level = "PluginSecurity",
        },
        sourcemap = {
          enabled = true,
          autogenerate = true, -- plugin runs rojo sourcemap for you
          rojo_project_file = "default.project.json",
          sourcemap_file = "sourcemap.json",
        },
        server = {
          -- point at Mason’s luau-lsp binary
          path = vim.fn.stdpath("data") .. "/mason/bin/luau-lsp",
        },
      })
    end,
  }
}
