local conform = require("conform")

local opts = {
  formatters_by_ft = {
    go = { "gofmt" },
    python = { "black" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    c = { "clang-format" },
  },
  format_on_save = {
    lsp_fallback = true,
  },
}

conform.setup(opts)
return opts
