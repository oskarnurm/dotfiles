return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
    },
    config = function()
      local lsp = require "lspconfig"

      lsp.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
              disable = { "missing-fields" },
            },
          },
        },
      }

      lsp.ts_ls.setup {}
      lsp.vtsls.setup {}
      lsp.pyright.setup {}
      lsp.clangd.setup {}
      lsp.jdtls.setup {}
    end,
  },
}
