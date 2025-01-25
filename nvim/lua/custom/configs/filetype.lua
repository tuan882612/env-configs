local M = {}

M.setup = function()
  local file_types = { "go", "java", "c", "cpp", "rust", "python", "javascript" }

  for _, filetype in ipairs(file_types) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype,
      callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true

        -- Trigger Conform formatting on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = vim.api.nvim_get_current_buf(),
          callback = function()
            require("conform").format { async = true }
          end,
        })
      end,
    })
  end
end

return M
