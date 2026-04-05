return {
  -- Ajouter le thème catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte / frappe / macchiato / mocha
      transparent_background = true, -- optionnel
      integrations = {
        telescope = true,
        treesitter = true,
        lsp_trouble = true,
        which_key = true,
        noice = true,
        mini = true,
        flash = true,
      },
    },
  },

  -- Configurer LazyVim pour utiliser Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
