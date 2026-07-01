-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth lsp")
end, {})

vim.api.nvim_create_user_command("LspRestart", function()
  for _, client in ipairs(vim.lsp.get_clients()) do
    client:stop()
  end
  vim.cmd("edit")
end, {})

vim.keymap.set("n", "<leader>p", function()
  print(vim.fn.expand("%:p"))
end, { desc = "custom Show full file path" })

vim.keymap.set("n", "<leader>gc", function()
  local files = vim.fn.systemlist("git diff --name-only --diff-filter=U")
  local items = {}

  for _, file in ipairs(files) do
    table.insert(items, {
      filename = file,
      lnum = 1,
      text = "git conflict",
    })
  end

  vim.fn.setqflist(items)
  vim.cmd("copen")
end, { desc = "custom Git: list conflicts (quickfix)" })

vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { silent = true, desc = "custom Quickfix next" })
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", { silent = true, desc = "custom Quickfix prev" })

vim.keymap.set("n", "<leader>xn", "]x", { remap = true, silent = true, desc = "custom Git conflict next" })

vim.keymap.set("n", "<leader>xp", "[x", { remap = true, silent = true, desc = "custom Git conflict prev" })
