require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "kj", "<ESC>")

map("n", "<leader>cf", function()
  require("conform").format { async = true }
end, { desc = "Format file with Conform" })

map("n", "<leader>r", ":%s///gc<Left><Left><Left>", { desc = "Search and replace interactively" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map('n', 'fr', function()
  vim.lsp.buf.references()
end, { desc = "Telescope find references"})
