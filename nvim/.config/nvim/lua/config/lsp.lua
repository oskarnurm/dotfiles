vim.lsp.enable({
  "eslint",
  "ts_ls",
  "tsgo",
  "cssls",
  "html",
  "tailwindcss",
  "lua_ls",
  "jdtls",
  "basedpyright",
  "clangd",
})
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
-- vim.lsp.document_color.enable(true, 0, { style = "virtual" })
