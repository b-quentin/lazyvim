local copilot_enabled = false

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    keys = {
      {
        "<leader>ct",
        function()
          local command = require("copilot.command")
          if copilot_enabled then
            command.disable()
            copilot_enabled = false
            vim.notify("Copilot disabled", vim.log.levels.INFO)
          else
            command.enable()
            copilot_enabled = true
            vim.notify("Copilot enabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle Copilot",
      },
    },
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-f>", -- Ctrl + f pour accepter la suggestion
          accept_word = false,
          accept_line = false,
          next = "<C-n>", -- Ctrl + n pour suivante
          prev = "<C-p>", -- Ctrl + p pour précédente
          dismiss = "<C-e>", -- Ctrl + e pour masquer
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
      -- setup() enables Copilot; turn it back off so it starts disabled.
      require("copilot.command").disable()
      copilot_enabled = false
    end,
  },
}
