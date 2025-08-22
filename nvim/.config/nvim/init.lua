vim.loader.enable()
vim.g.mapleader = " "

vim.cmd([[let &stc = '%s %5l ']])
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.confirm = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.neovim/undodir"
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "yes"
vim.opt.completeopt = "menuone,noinsert,preview"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.winborder = "single"
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.diagnostic.config({ virtual_text = true, underline = false })
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Plugins, bloated?
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
})

-- Helper mapping function - mode is required, buf is optional
local map = function(mode, keys, func, desc, buf)
  local opts = { desc = desc }
  if buf then
    opts.buffer = buf
  end
  vim.keymap.set(mode, keys, func, opts)
end

-- LSP
vim.lsp.enable({ "cssls", "html", "clangd", "tailwindcss", "jdtls", "basedpyright", "tsgo", "lua_ls" })

require("mason").setup()
require("mini.pick").setup()
require("which-key").setup()
require("nvim-ts-autotag").setup()
require("blink.cmp").setup()
require("oil").setup({ view_options = { show_hidden = true } })

require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

require("conform").setup({
  format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    html = { "prettierd" },
    python = { "ruff_format" },
    sh = { "shfmt" },
    java = { "google-java-format" },
    ["_"] = { "prettierd" },
  },
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
  indent = { enable = true, disable = { "ruby" } },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = { query = "@function.outer" },
        ["if"] = { query = "@function.inner" },
        ["ac"] = { query = "@conditional.outer" },
        ["ic"] = { query = "@conditional.inner" },
        ["al"] = { query = "@loop.outer" },
        ["il"] = { query = "@loop.inner" },
      },
      include_surrounding_whitespace = true,
    },
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Stage hunk", bufnr)
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Reset hunk", bufnr)
    map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Hunk", bufnr)
    map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer", bufnr)
    map("n", "<leader>hr", gitsigns.reset_hunk, "Reset Hunk", bufnr)
    map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer", bufnr)
    map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Hunk", bufnr)
  end,
})

-- General mappings
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear highlights")
map("n", "[[", "<cmd>cprev<CR>", "Previous quickfix")
map("n", "]]", "<cmd>cnext<CR>", "Next quickfix")
map("n", "<C-Space>", "<C-x><C-o>", "Trigger completion")
map("v", "K", ":m '<-2<CR>gv=gv", "Move line up")
map("v", "J", ":m '>+1<CR>gv=gv", "Move line down")
map("n", "x", '"_x', "Delete without yank")
map("v", "x", '"_x', "Delete without yank")
map("n", "c", [["_c]], "Change without yank")
map("v", "c", [["_c]], "Change without yank")
map("n", "C", [["_C]], "Change line without yank")
map("v", "C", [["_C]], "Change line without yank")

-- Quickfix toggle
map("n", "<leader>q", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, "Toggle quickfix")

-- Tool mappings
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", "Toggle undotree")
map("n", "<leader>gc", "<cmd>Git commit<CR>", "Git commit")
map("n", "<leader>o", "<cmd>Oil<CR>", "Open file explorer")

-- Picker mappings
local picker = require("mini.pick").builtin
map("n", "<leader><space>", picker.buffers, "Find buffers")
map("n", "<leader>fh", picker.help, "Find help")
map("n", "<leader>fg", picker.grep_live, "Live grep")
map("n", "<leader>fn", function()
  picker.files({}, { source = { cwd = vim.fn.stdpath("config") } })
end, "Find config files")
map("n", "<leader>ff", function()
  picker.files({ tool = vim.uv.fs_stat(".git") and "git" or "rg" })
end, "Find files")

-- LSP mappings
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", {}),
  callback = function(e)
    vim.lsp.document_color.enable(true, e.buf, { style = "virtual" })

    map("n", "grn", vim.lsp.buf.rename, "Rename symbol", e.buf)
    map("n", "gra", vim.lsp.buf.code_action, "Code action", e.buf)
    map("n", "grr", vim.lsp.buf.references, "References", e.buf)
    map("n", "gri", vim.lsp.buf.implementation, "Implementation", e.buf)
    map("n", "grt", vim.lsp.buf.type_definition, "Type definition", e.buf)
    map("n", "gO", vim.lsp.buf.document_symbol, "Document symbols", e.buf)
    map("n", "grD", vim.lsp.buf.declaration, "Declaration", e.buf)
    map("n", "grd", vim.lsp.buf.definition, "Definition", e.buf)
  end,
})
