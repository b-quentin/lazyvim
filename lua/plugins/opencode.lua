return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- optionnel : assure-toi d'avoir la dernière
    dependencies = {
      {
        "folke/snacks.nvim", -- recommandé pour l’input & select
        optional = true,
        opts = {
          input = {}, -- améliore require("opencode").ask()
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
          },
        },
      },
    },
    config = function()
      -- ⚙️ Options opencode
      vim.g.opencode_opts = {
        -- Exemple : change l’adresse du serveur si besoin
        -- server = { port = 8080 },
        -- ou rajoute des prompts custom
        -- prompts = { myprompt = { description="Fais ceci", prompt="…" } },
      }

      -- nécessaire pour recharger quand opencode modifie un fichier
      vim.o.autoread = true

      -- 🧠 Keymaps unifiés avec LazyVim (<leader>ao prefix)
      -- Évite les conflits avec ClaudeCode (ac, af, ar, aC, ab, as, aa, ad)
      vim.keymap.set({ "n", "x" }, "<leader>ao", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })

      vim.keymap.set({ "n", "x" }, "<leader>aO", function()
        require("opencode").select()
      end, { desc = "Open opencode selector" })

      vim.keymap.set({ "n", "t" }, "<leader>at", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode panel" })
    end,
  },
}
