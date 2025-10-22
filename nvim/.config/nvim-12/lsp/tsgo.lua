-- Install with: npm i -g @typescript/native-preview

---@type vim.lsp.Config
return {
  cmd = { "tsgo", "--lsp", "--stdio" },
  filetypes = { "typescript", "typescriptreact" },
}
