local M = {}

M.setup = function()
  -- General keymaps
  vim.keymap.set("n", "<leader>cf", function()
    require("conform").format { async = true }
  end, { desc = "Format file with Conform" })
end

return M
