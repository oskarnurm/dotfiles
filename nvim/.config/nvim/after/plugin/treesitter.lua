local ensure_installed = {
  "c",
  "go",
  "lua",
  "vim",
  "css",
  "cpp",
  "tsx",
  "yaml",
  "toml",
  "json",
  "rust",
  "bash",
  "make",
  "html",
  "jsdoc",
  "diff",
  "svelte",
  "query",
  "luadoc",
  "vimdoc",
  "python",
  "comment",
  "markdown",
  "gitcommit",
  "gitignore",
  "git_config",
  "git_rebase",
  "javascript",
  "typescript",
  "gitattributes",
  "editorconfig",
  "markdown_inline",
}

require("nvim-treesitter").install(ensure_installed)

local filetypes = vim.iter(ensure_installed):map(vim.treesitter.language.get_filetypes):flatten():totable()

-- enable treesitter for all installed languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function(event) vim.treesitter.start(event.buf) end,
})
