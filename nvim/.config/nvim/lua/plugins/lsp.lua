return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lsp = require 'lspconfig'

      lsp.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
              disable = { 'missing-fields' },
            },
          },
        },
      }

      lsp.ts_ls.setup { capabilities = capabilities }
      lsp.vtsls.setup { capabilities = capabilities }
      lsp.pyright.setup { capabilities = capabilities }
      lsp.clangd.setup { capabilities = capabilities }

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local map = function(mode, keys, func, desc)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
          map('n', 'gr', vim.lsp.buf.references, '[G]oto [R]eferences')
          map('n', 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('n', 'gI', vim.lsp.buf.implementation, '[G]oto [I]implementation')
          map('n', 'go', vim.lsp.buf.type_definition, '[G]oto Type Definition')
          map('n', 'gs', vim.lsp.buf.signature_help, '[G]oto [S]ignature Help')
          map('n', 'rn', vim.lsp.buf.rename, '[R]ename [N]ame')
          -- map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('n', '<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')
        end,
      })
    end,
  },
}
