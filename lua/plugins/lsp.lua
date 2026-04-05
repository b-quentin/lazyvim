return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- === GOLANG LSP ===
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        -- === VLANG LSP ===
        v_analyzer = {},
      },
    },
  },
}
