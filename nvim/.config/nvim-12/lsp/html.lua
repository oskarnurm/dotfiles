---@brief
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- `vscode-html-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g vscode-langservers-extracted

---@type vim.lsp.Config
return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  root_markers = { "package.json", ".git" },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
}
