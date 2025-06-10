require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "ej", "<ESC>")

map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename variable using LSP" })
map("v", "<leader>r", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]],
  { desc = "Replace selected text" })

map("n", "gd", vim.lsp.buf.definition, { desc = "Jumps directly to where a function, var, or type is defined." })
map("n", "gr", vim.lsp.buf.references, { desc = "Shows all places where the current symbol is used in project." })

map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("v", "<Tab>", ">gv", { desc = "Indent selected text" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selected text" })
