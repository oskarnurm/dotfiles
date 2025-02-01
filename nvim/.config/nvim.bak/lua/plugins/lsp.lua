return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },

    config = function()
      require('mason').setup()

      -- local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require 'lspconfig'

      local handlers = {
        function(server_name)
          lspconfig[server_name].setup { capabilities = capabilities }
        end,

        ['lua_ls'] = function()
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
              },
            },
          }
        end,
      }

      require('mason-lspconfig').setup { handlers = handlers }

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
          map('n', '<leader>rn', vim.lsp.buf.rename, '[R]ename [N]ame')
          -- map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('n', '<leader>cf', vim.lsp.buf.format, '[C]ode [F]ormat')
        end,
      })
    end,
  },
}
