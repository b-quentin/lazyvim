return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>df", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "History" },
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false, -- show diffs for binaries
        enhanced_diff_hl = true,
        use_icons = true, -- requires nvim-web-devicons
        signs = {
          fold_closed = "",
          fold_open = "",
        },
        file_panel = {
          win_config = {
            position = "left",
            width = 35,
          },
          listing_style = "tree",
        },
        file_history_panel = {
          win_config = {
            position = "bottom",
            height = 16,
          },
        },
        key_bindings = {
          disable_defaults = false,
          view = {
            ["<tab>"] = require("diffview.config").actions.select_next_entry,
            ["<s-tab>"] = require("diffview.config").actions.select_prev_entry,
            ["<leader>e"] = require("diffview.config").actions.focus_files,
            ["<leader>b"] = require("diffview.config").actions.toggle_files,
          },
          file_panel = {
            ["j"] = require("diffview.config").actions.next_entry,
            ["k"] = require("diffview.config").actions.prev_entry,
            ["<cr>"] = require("diffview.config").actions.select_entry,
            ["-"] = require("diffview.config").actions.toggle_stage_entry,
          },
        },
      })
    end,
  },
}
