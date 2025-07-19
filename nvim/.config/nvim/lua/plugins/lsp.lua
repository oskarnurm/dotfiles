return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
    "saghen/blink.cmp",
  },
  vim.lsp.enable { "html", "clangd", "tailwindcss", "jdtls", "basedpyright", "ts_ls", "vtsls", "lua_ls" },
}
