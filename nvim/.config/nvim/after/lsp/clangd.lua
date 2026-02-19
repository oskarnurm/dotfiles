---@brief
--
-- macOS: `brew install llvm`
-- Arch: `pacman -S clang`
-- Ubuntu: `apt install clangd`

---@type vim.lsp.Config
return {
  cmd = {
    "clangd",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--fallback-style=none",
    "--function-arg-placeholders=false",
  },
  filetypes = { "c", "cpp" },
  root_markers = {
    ".clangd",
    "compile_commands.json",
    "Makefile",
    ".git",
  },
}
