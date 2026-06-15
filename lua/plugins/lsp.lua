return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
            },
          },
        },
        v_analyzer = {},
        nushell = {},
        emmet_language_server = {
          filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
        },
        cssls = {},
        vtsls = {},
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },

        jsonls = {
          filetypes = {
            "json",
            "jsonc",
          },
          settings = {
            json = {
              validate = {
                enable = true,
              },
            },
          },
        },
      },

      setup = {
        eslint = function()
          local function get_client(buf)
            return vim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          LazyVim.format.register(formatter)
        end,
      },
    },
  },
}
