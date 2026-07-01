return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-f>", -- Ctrl + f pour accepter la suggestion
          accept_word = false,
          accept_line = false,
          next = "<C-n>",   -- Ctrl + n pour suivante
          prev = "<C-p>",   -- Ctrl + p pour précédente
          dismiss = "<C-e>",-- Ctrl + e pour masquer
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
  },
}
