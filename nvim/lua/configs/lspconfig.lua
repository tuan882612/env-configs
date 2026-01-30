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

local function luau_root_from_arg(arg)
  local fname

  if type(arg) == "number" then
    fname = vim.api.nvim_buf_get_name(arg)
  else
    fname = arg
  end

  if not fname or fname == "" then
    return vim.uv.cwd()
  end

  local dir = vim.fs.dirname(fname) or vim.uv.cwd()
  local root = vim.fs.root(dir, {
    "default.project.json",
    "sourcemap.json",
    ".luaurc",
    ".git",
  })

  -- Support *.project.json via find
  if not root then
    local proj = vim.fs.find(function(name)
      return name:match("%.project%.json$")
    end, { upward = true, path = dir })[1]

    if proj then
      root = vim.fs.dirname(proj)
    end
  end

  return root or dir
end

-- Neovim built-in LSP expects root_dir(bufnr, cb)
local function luau_root(bufnr, cb)
  cb(luau_root_from_arg(bufnr))
end

-- Optional: treat *.lua as Luau only inside Rojo/Luau roots
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = "*.lua",
  callback = function(args)
    local root = luau_root_from_arg(args.buf)
    local is_rojo = vim.fs.find(
      { "default.project.json", "sourcemap.json", ".luaurc" },
      { upward = true, path = root }
    )[1]
    if is_rojo then
      vim.bo[args.buf].filetype = "luau"
    end
  end,
})

-- Resolve executable (PATH first, then mason)
local luau_bin = vim.fn.exepath("luau-lsp")

if luau_bin == "" then
  luau_bin = vim.fn.stdpath("data") .. "/mason/bin/luau-lsp"
end

-- Configure
vim.lsp.config("luau_lsp", with_defaults({
  cmd = { luau_bin, "lsp" }, -- if needed: { luau_bin, "--stdio" }
  filetypes = { "luau" },
  root_dir = luau_root,
  settings = {
    ["luau-lsp"] = {
      platform = { type = "roblox" },
    },
  },
}))

-- Ensure it's enabled
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
