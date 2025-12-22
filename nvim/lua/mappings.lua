require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("t", "<leader>h", [[<C-\><C-n>]], { silent = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "ej", "<ESC>")

map("v", "<leader>rr", [[:<C-u>'<,'>s/<C-r><C-w>//gI<Left><Left><Left>]],
  { desc = "Replace word under cursor in selection" })
map("v", "<leader>ra", [[:<C-u>%s/<C-r><C-w>//gI<Left><Left><Left>]],
  { desc = "Replace word under cursor in entire file" })

map("n", "gh", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in horizontal split" })
map("n", "gr", vim.lsp.buf.references, { desc = "Shows all places where the current symbol is used in project." })
map("n", "J", "/", { desc = "Quick pattern search" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
-- Home/End on H/L
map({ "n", "x", "o" }, "H", "^", { desc = "Start of line (first non-blank)" })
map({ "n", "x", "o" }, "L", "$", { desc = "End of line (last non-blank)" })
-- If you want true end-of-line including trailing spaces

map("i", "<Tab>", "<Tab>", { noremap = true, desc = "Insert real tab or spaces" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("v", "<Tab>", ">gv", { desc = "Indent selected text" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selected text" })
