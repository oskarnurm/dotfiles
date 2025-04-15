return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
    },
    -- We can lazy load the plugin to save a few milliseconds of startup time,
    -- we just need the nvim-lspconfig in the runtime path
    lazy = true,
    init = function()
      local lspcconfig_path = require("lazy.core.config").options.root .. "/nvim-lspconfig"
      vim.opt.runtimepath:append(lspcconfig_path)

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
