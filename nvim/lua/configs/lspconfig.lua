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

vim.lsp.config("html", with_defaults({
  -- html-lsp (vscode-langservers-extracted) typically uses "html" id
  filetypes = { "html" },
  root_markers = { "index.html", ".git" },
  settings = {
    html = {
      format = { wrapLineLength = 120, indentInnerHtml = true },
    },
  },
}))

vim.lsp.config("tailwindcss", with_defaults({
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.mjs",
    "postcss.config.ts",
    "package.json",
    ".git",
  },
  init_options = {
    userLanguages = {
      -- example: if you use Tailwind in JSX/TSX, these help detection
      eelixir = "html-eex",
      eruby = "erb",
    },
  },
}))

vim.lsp.config("eslint", with_defaults({
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
  },
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.mjs",
    ".eslintrc.json",
    "package.json",
    ".git",
  },
  settings = {
    -- typically keep formatting off here if you use prettier/prettierd
    format = false,
    workingDirectory = { mode = "auto" },
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
}))

vim.lsp.config("lua_ls", with_defaults({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}))

-- luau-lsp 
-- Ensure *.luau is recognized
vim.filetype.add({ extension = { luau = "luau" } })

local function luau_root(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(fname)

  return vim.fs.root(dir, function(name, _)
    return name == "default.project.json"
      or name == "sourcemap.json"
      or name == ".luaurc"
      or name:match("%.project%.json$") ~= nil
  end)
end

-- If your Rojo project uses *.lua files, treat them as Luau inside Rojo roots
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.lua",
  callback = function(args)
    if luau_root(args.buf) then
      vim.bo[args.buf].filetype = "luau"
    end
  end,
})

vim.lsp.config("luau_lsp", with_defaults({
  -- nvim-lspconfig’s luau_lsp uses: luau-lsp lsp :contentReference[oaicite:0]{index=0}
  cmd = { "luau-lsp", "lsp" },
  filetypes = { "luau" },
  root_dir = luau_root,

  -- Helps the server notice sourcemap.json changes when using Rojo sourcemaps :contentReference[oaicite:1]{index=1}
  capabilities = vim.tbl_deep_extend("force", nvlsp.capabilities, {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = true },
    },
  }),

  settings = {
    ["luau-lsp"] = {
      platform = { type = "roblox" },
    },
  },
}))

vim.lsp.enable({
  "gopls",
  "ruff",
  "pyright",
  "zls",
  "rust_analyzer",
  "clangd",
  "ts_ls",
  "html",
  "tailwindcss",
  "eslint",
  "lua_ls",
  "luau_lsp"
})
