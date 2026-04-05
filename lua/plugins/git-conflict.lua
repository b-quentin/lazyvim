
return {
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPost",
    config = function()
      require("git-conflict").setup({
        default_mappings = true, -- active les mappings par défaut
        disable_diagnostics = false, -- garde les diagnostics actifs
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })
    end,
  },
}

