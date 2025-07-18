return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", tag = "v1.11.0", opts = {} },
    { "mason-org/mason-lspconfig.nvim", tag = "v1.32.0" },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "Rename")
        map("gra", vim.lsp.buf.code_action, "Goto Code Action", { "n", "x" })
        map("grr", vim.lsp.buf.references, "Goto References")
        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gri", vim.lsp.buf.implementation, "Goto Implementation")
        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("grd", vim.lsp.buf.definition, "Goto Definition")
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("grD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gO", vim.lsp.buf.document_symbol, "Open Document Symbols")
        map("gW", vim.lsp.buf.workspace_symbol, "Open Workspace Symbols")
        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("grt", vim.lsp.buf.type_definition, "Goto Type Definition")
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local servers = {
      clangd = {},
      tailwindcss = {},
      jdtls = {},
      pyright = {},
      ts_ls = {},
      vtsls = {
        settings = {
          vtsls = { autoUseWorkspaceTsdk = true },
        },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua",
      "shfmt",
      "black",
      "prettier",
      "htmlbeautifier",
      "google-java-format",
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      ensure_installed = {}, -- explicitly set to an empty table (we populate installs via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
