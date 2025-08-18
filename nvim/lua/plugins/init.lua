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
}
