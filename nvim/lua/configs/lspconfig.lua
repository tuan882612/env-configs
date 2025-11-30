-- Load NvChad’s default LSP settings (lua_ls, capabilities, etc.)
local nvlsp = require("nvchad.configs.lspconfig")
nvlsp.defaults()

-- Helper to apply NvChad defaults to each server
local function with_defaults(opts)
  return vim.tbl_deep_extend("force", {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }, opts or {})
end

-- gopls (Go)
vim.lsp.config("gopls", with_defaults({
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}))

-- ruff (Python linter LSP)
vim.lsp.config("ruff", with_defaults({
  filetypes = { "python" },
  root_markers = { "pyproject.toml", ".git" },
}))

-- pyright (Python)
vim.lsp.config("pyright", with_defaults({
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        diagnosticMode = "workspace",
      },
      pythonPath = vim.fn.exepath("python"),
    },
  },
}))

-- zls (Zig)
vim.lsp.config("zls", with_defaults({
  cmd = { "zls" },
  filetypes = { "zig" },
  root_markers = { "build.zig", ".git" },
}))

-- rust-analyzer
vim.lsp.config("rust_analyzer", with_defaults({
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = { command = "clippy" },
    },
  },
}))

-- clangd (C/C++)
vim.lsp.config("clangd", with_defaults({
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
}))

-- typescript-language-server
vim.lsp.config("ts_ls", with_defaults({
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = { "package.json", "tsconfig.json", ".git" },

  on_attach = function(client, bufnr)
    if client.name == "tsserver" or client.name == "ts_ls" then
      client.server_capabilities.documentFormattingProvider = false
    end

    nvlsp.on_attach(client, bufnr)
  end,
}))

vim.lsp.enable({
  "gopls",
  "ruff",
  "pyright",
  "zls",
  "rust_analyzer",
  "clangd",
  "ts_ls",
})
