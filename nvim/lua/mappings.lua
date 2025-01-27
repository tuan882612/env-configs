require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>cf", function()
  require("conform").format { async = true }
end, { desc = "Format file with Conform" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
