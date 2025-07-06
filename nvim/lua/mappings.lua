require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "ej", "<ESC>")

map("v", "<leader>rw", [[:<C-u>'<,'>s/<C-r><C-w>//gI<Left><Left><Left>]],
  { desc = "Replace word under cursor in selection" })

map("n", "gh", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end, { desc = "Go to definition in horizontal split" })
map("n", "gr", vim.lsp.buf.references, { desc = "Shows all places where the current symbol is used in project." })
map("n", "J", "/", { desc = "Quick pattern search" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("v", "<Tab>", ">gv", { desc = "Indent selected text" })
map("v", "<S-Tab>", "<gv", { desc = "Unindent selected text" })
