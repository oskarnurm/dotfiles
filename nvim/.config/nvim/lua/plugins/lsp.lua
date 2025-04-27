return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
    },
    -- lazy = true,
    config = function()
      -- local lspcconfig_path = require("lazy.core.config").options.root .. "/nvim-lspconfig"
      -- vim.opt.runtimepath:append(lspcconfig_path)

      vim.lsp.enable { "lua_ls", "ts_ls", "vtsls", "pyright", "clangd", "jdtls" }

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
}
