return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
    -- Blink-based completion (no manual capabilities merge needed)
    "saghen/blink.cmp",
  },
  -- Allows extra capabilities provided. Uncomment this section if not using blink.cmp
  -- vim.lsp.config("*", {
  -- capabilities = vim.lsp.protocol.make_client_capabilities()
  -- })
  --

  -- Set custom settings for servers
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
        diagnostics = { disable = { "missing-fields" } },
      },
    },
  }),

  -- Add servers to the list to enable them
  vim.lsp.enable {
    "cssls",
    "html",
    "clangd",
    "tailwindcss",
    "jdtls",
    "basedpyright",
    "ts_ls",
    "lua_ls",
  },
}
