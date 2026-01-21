local ensure_installed = {
  "bash",
  "c",
  "diff",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "printf",
  "python",
  "query",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

local TS = require("nvim-treesitter")
TS.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TSAutoInstall", { clear = true }),
  callback = function(args)
    local buffer = args.buf
    local lang = args.match

    TS.install(lang):await(function()
      if not vim.api.nvim_buf_is_loaded(buffer) then return end

      local installed = TS.get_installed()
      if vim.list_contains(installed, lang) then vim.treesitter.start(buffer) end
    end)
  end,
})
