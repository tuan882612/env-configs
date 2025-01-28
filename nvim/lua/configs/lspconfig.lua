-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require("lspconfig.util")

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {
    "go", "gomod", "gowork", "gotmpl",
  },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.ruff.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"ruff-lsp"},
  filetypes = {
    "python",
  },
  root_dir = util.root_pattern("pyproject.toml", ".git"),
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git"),
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        diagnosticMode = "workspace",
      },
    },
  },
}

lspconfig.zls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
}