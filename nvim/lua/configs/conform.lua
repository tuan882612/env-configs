local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports_reviser" },
    python = { "black" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    c = {
      "clang-format",
      args = { "--style={IndenWidth: 4, UseTab: Always, TabWith: 4}" }
    },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
