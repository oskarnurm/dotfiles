return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
    },
    config = function()
      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require 'lspconfig'

      lsp.lua_ls.setup {
        -- capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
              disable = { 'missing-fields' },
            },
          },
        },
      }

      lsp.ts_ls.setup {}
      lsp.vtsls.setup {}
      lsp.pyright.setup {}
      lsp.clangd.setup {}
    end,
  },
}
