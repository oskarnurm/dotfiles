_G.Config = {}

vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") },
})

vim.opt.runtimepath:prepend("~/odin/koda.nvim")
vim.cmd.colorscheme("koda")

local gr = vim.api.nvim_create_augroup("custom-config", { clear = true })
Config.autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

Config.later = function(f) require("mini.misc").safely("later", f) end

Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback()
  end
  Config.autocmd("PackChanged", "*", f, desc)
end

require("mini.icons").setup()
require("mini.extra").setup()
local ai = require("mini.ai")
ai.setup({
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
    o = ai.gen_spec.treesitter({
      a = { "@conditional.outer", "@loop.outer" },
      i = { "@conditional.inner", "@loop.inner" },
    }),
  },
})

local hipatterns = require("mini.hipatterns")
hipatterns.setup({ highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() } })

require("mini.indentscope").setup()
require("mini.pick").setup()
require("mini.surround").setup()

require("which-key").setup({ preset = "helix", icons = { mappings = false } })
require("oil").setup({ view_options = { show_hidden = true } })
require("blink.cmp").setup()
require("mason").setup()

require("conform").setup({
  format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
  formatters_by_ft = {
    sh = { "shfmt" },
    lua = { "stylua" },
    python = { "ruff_format" },
    c = { lsp_format = "prefer" },
    -- java = { "google-java-format" },
    java = { lsp_format = "prefer" },
    xml = { "xmlformatter" },
    ["_"] = { "prettierd" },
  },
})

local ts_update = function() vim.cmd("TSUpdate") end
Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

local languages = {
  -- To see available languages: `:=require('nvim-treesitter').get_available()`
  -- - Visit 'SUPPORTED_LANGUAGES.md' file at
  --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
  "bash",
  "c",
  "diff",
  "html",
  "query",
  "javascript",
  "typescript",
  "tsx",
  "python",
  "json",
  "go",
  "java",
  "rust",
  "comment",
  "markdown",
  "markdown_inline",
}
local not_installed = function(lang) return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0 end
local to_install = vim.tbl_filter(not_installed, languages)
if #to_install > 0 then require("nvim-treesitter").install(to_install) end

-- Enable tree-sitter after opening a file for a target language
local filetypes = {}
for _, lang in ipairs(languages) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    table.insert(filetypes, ft)
  end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end
Config.autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "v",
      ["@class.outer"] = "<c-v>",
    },
    include_surrounding_whitespace = false,
  },
})

Config.later(
  function()
    vim.lsp.enable({
      "basedpyright",
      "bashls",
      "clangd",
      "cssls",
      "gopls",
      "html",
      "jdtls",
      "jsonls",
      "lua_ls",
      "rust_analyzer",
      "tailwindcss",
      "tsgo",
    })
  end
)
