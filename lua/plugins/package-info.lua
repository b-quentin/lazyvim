return {
  {
    "vuki656/package-info.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "BufRead package.json",
    config = function()
      require("package-info").setup({
        autostart = true,
        hide_up_to_date = true,
        hide_unstable_versions = false,
      })

      vim.keymap.set("n", "<leader>ns", require("package-info").show, { desc = "Afficher les versions npm" })

      vim.keymap.set("n", "<leader>nc", require("package-info").hide, { desc = "Masquer les versions npm" })

      vim.keymap.set("n", "<leader>nu", require("package-info").update, { desc = "Mettre à jour la dépendance npm" })

      vim.keymap.set("n", "<leader>nd", require("package-info").delete, { desc = "Supprimer la dépendance npm" })

      vim.keymap.set(
        "n",
        "<leader>ni",
        require("package-info").install,
        { desc = "Installer une nouvelle dépendance npm" }
      )
    end,
  },
}
