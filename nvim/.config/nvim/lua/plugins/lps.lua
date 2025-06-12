return {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "clangd",
          "pyright",
          "ts_ls",
          "lua_ls",
        },
        -- automatic_enable = true,  -- default
      },
    },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = { "stylua" },
      },
    },

    -- Blink-based completion (no manual capabilities merge needed)
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-keymaps", { clear = true }),
      callback = function(ev)
        local map = function(keys, fn, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "Rename")
        map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("grr", vim.lsp.buf.references, "References")
        map("gri", vim.lsp.buf.implementation, "Implementation")
        map("grd", vim.lsp.buf.definition, "Definition")
        map("grD", vim.lsp.buf.declaration, "Declaration")
        map("grt", vim.lsp.buf.type_definition, "Type Definition")
        map("gO", vim.lsp.buf.document_symbol, "Document Symbols")
        map("gW", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
      end,
    })

    -- Configure each server via the native API
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    })
  end,
}
