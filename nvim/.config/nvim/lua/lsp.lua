vim.diagnostic.config({ virtual_text = true, underline = false })
-- vim.lsp.document_color.enable(true, 0, { style = "virtual" })
--
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
