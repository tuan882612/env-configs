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

  -- Copilot Plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = false,
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
  }
}
