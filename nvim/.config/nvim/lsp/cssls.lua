---@brief
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- `css-languageserver` can be installed via `npm`:
---
--- ```sh
--- npm i -g vscode-langservers-extracted
--- ```

---@type vim.lsp.Config
return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
  root_markers = { "package.json", ".git" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
