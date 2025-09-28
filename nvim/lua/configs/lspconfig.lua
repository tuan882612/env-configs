require("nvchad.configs.lspconfig").defaults()

-- You can still use lspconfig.util for root detection (data-only)
local util = require("lspconfig.util")

-- Shared opts
local on_attach = on_attach
local capabilities = capabilities

-- gopls
vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = { unusedparams = true },
    },
  },
})
vim.lsp.enable('gopls')

-- ruff
vim.lsp.config('ruff', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
  root_dir = util.root_pattern("pyproject.toml", ".git"),
})
vim.lsp.enable('ruff')

-- pyright
vim.lsp.config('pyright', {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
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
})
vim.lsp.enable('pyright')

-- zls
vim.lsp.config('zls', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "zig" },
  cmd = { "zls" },
  root_dir = util.root_pattern("build.zig", ".git"),
})
vim.lsp.enable('zls')

-- clangd
vim.lsp.config('clangd', {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
  root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})
vim.lsp.enable('clangd')

-- TypeScript: tsserver was renamed to ts_ls in lspconfig
vim.lsp.config('ts_ls', {
  on_attach = function(client, bufnr)
    -- prevent LSP formatting to avoid conflicts with prettier/etc.
    client.server_capabilities.documentFormattingProvider = false
    if type(on_attach) == "function" then on_attach(client, bufnr) end
  end,
  capabilities = capabilities,
  root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
})
vim.lsp.enable('ts_ls')
