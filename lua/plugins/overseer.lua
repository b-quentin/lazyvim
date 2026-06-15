return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerQuickAction",
  },

  opts = {
    strategy = "toggleterm",
    templates = { "builtin", "user.nushell" },
  },

  keys = {
    { "<leader>rr", "<cmd>OverseerRun<cr>", desc = "Run task" },
    { "<leader>rl", "<cmd>OverseerToggle<cr>", desc = "Task list" },
    { "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
  },
}
