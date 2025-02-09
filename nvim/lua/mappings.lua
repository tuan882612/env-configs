require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "kj", "<ESC>")

map("n", "<leader>rr", ":,s///g<Left><Left><Left>", { noremap = true, silent = false, desc = "Replace all within range"})
map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename variable using LSP" })

map("n", "<leader>fr", function()
  vim.lsp.buf.references()
end, { desc = "Telescope find references"})
