-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false  -- utiliser de vrais tabs, pas des espaces
    vim.opt_local.shiftwidth = 4     -- largeur d'une indentation
    vim.opt_local.tabstop = 4        -- largeur d'une tabulation
    vim.opt_local.softtabstop = 4
  end,
})
