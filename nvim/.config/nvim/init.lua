vim.loader.enable()

-- Options
local o = vim.opt
local g = vim.g

-- general
g.mapleader = " "

o.mouse = "a"
o.confirm = true
o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 300

-- ui
o.list = true
o.number = true
o.scrolloff = 10
o.cursorline = true
o.splitright = true
o.splitbelow = true
o.signcolumn = "yes"
o.winborder = "single"
o.termguicolors = true
o.relativenumber = true
vim.opt.statuscolumn = "%l  "
o.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.lsp.document_color.enable(true, 0, { style = "virtual" })
vim.diagnostic.config({ virtual_text = true, underline = false })

-- editing
o.tabstop = 2
o.wrap = false
o.shiftwidth = 2
o.smartcase = true
o.expandtab = true -- convert tabs to spaces
o.ignorecase = true
o.smartindent = true
o.inccommand = "split" -- preview substitutions live
o.virtualedit = "block"
o.spelloptions = "camel" -- treat camelCase word parts as separate words
o.iskeyword = "@,48-57,_,192-255,-" -- treat dash as `word` textobject part
o.completeopt = "menuone,noinsert,preview,fuzzy"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0

-- see full list:
-- https://github.com/neovim/neovim/tree/master/runtime/plugin
g.loaded_man = 1
g.loaded_gzip = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_remote_plugins = 1

vim.schedule(function() vim.o.clipboard = "unnamedplus" end) -- to avoid increasing startup-time

-- plugins
vim.pack.add({
  { src = "https://github.com/mbbill/undotree.git" },
  { src = "https://github.com/stevearc/oil.nvim.git" },
  { src = "https://github.com/nvim-mini/mini.ai.git" },
  { src = "https://github.com/folke/snacks.nvim.git" },
  { src = "https://github.com/tpope/vim-fugitive.git" },
  { src = "https://github.com/cbochs/grapple.nvim.git" },
  { src = "https://github.com/folke/which-key.nvim.git" },
  { src = "https://github.com/stevearc/conform.nvim.git" },
  { src = "https://github.com/dmtrKovalenko/fff.nvim.git" },
  { src = "https://github.com/windwp/nvim-ts-autotag.git" }, -- TODO: consider removing this plugin
  { src = "https://github.com/lewis6991/gitsigns.nvim.git" },
  { src = "https://github.com/oskarnurm/chiefdog.nvim.git" },
  { src = "https://github.com/rafamadriz/friendly-snippets.git" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
  { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") },
})

-- Setup
vim.cmd("colorscheme chiefdog")

require("mini.ai").setup()
require("blink.cmp").setup()
require("nvim-ts-autotag").setup()
require("fff").setup({ prompt = "> " })
require("oil").setup({ view_options = { show_hidden = true } })
require("grapple").setup({ scope = "git_branch", icons = false })
require("which-key").setup({ preset = "helix", icons = { mappings = false } })

require("snacks").setup({
  input = { enabled = true },
  words = { enabled = true },
  scope = { enabled = true },
  picker = { enabled = true },
  indent = { enabled = true },
  quickfile = { enabled = true },
})

require("conform").setup({
  format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
  formatters_by_ft = {
    sh = { "shfmt" },
    lua = { "stylua" },
    html = { "prettierd" },
    python = { "ruff_format" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    c = { lsp_format = "prefer" },
    java = { "google-java-format" },
    ["_"] = { "prettierd" },
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
    local gs = require("gitsigns")
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]h", function() gs.nav_hunk("next") end, { desc = "Next Hunk" })
    map("n", "[h", function() gs.nav_hunk("prev") end, { desc = "Previous Hunk" })
    map(
      "v",
      "<leader>hs",
      function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      { desc = "Stage hunk" }
    )
    map(
      "v",
      "<leader>hr",
      function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      { desc = "Reset hunk" }
    )
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
    map("n", "<leader>hb", gs.blame_line, { desc = "Blame Line" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Blame Line" })
    map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Hunk" })
  end,
})

-- Mappings
local map = vim.keymap.set

map({ "n", "v", "x" }, ";", ":")
map({ "n", "v", "x" }, ":", ";")
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "c", [["_c]])
map({ "n", "v" }, "C", [["_C]])
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<C-n>", "<cmd>cnext<CR>zz")
map("n", "<C-p>", "<cmd>cprev<CR>zz")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
map("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitue Word" })
map("n", "<leader>af", "<cmd>vert sf #<CR>", { desc = "Split Alternative File" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- map("n", "<leader>b", ":ls<CR>:b ", { desc = "Show Buffers" })

-- toggle quickfix list
map("n", "<leader>q", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Quickfix List" })

-- toggle location list
map("n", "<leader>l", function()
  if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
    vim.cmd.lclose()
  else
    pcall(vim.cmd.lopen) -- lopen can fail if the location list is empty, so 'pcall' or a check is useful here.
  end
end, { desc = "Location List" })

map("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
map("n", "<leader>o", "<cmd>Oil<CR>")
map("n", "<leader>sf", function() require("fff").find_files() end, { desc = "FFFind files" })

-- snacks: pickers
---@diagnostic disable: undefined-global
-- map("n", "<leader>sf", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sc", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", "<leader>/", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffer" })

-- snacks: utility
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
map("n", "<leader>cr", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
map("n", "<c-_>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })

-- snacks: toggle
Snacks.toggle.dim():map("<leader>tD")
Snacks.toggle.indent():map("<leader>ti")
Snacks.toggle.diagnostics():map("<leader>td")
Snacks.toggle.treesitter():map("<leader>tt")
Snacks.toggle.line_number():map("<leader>tl")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>tb")

-- grapple
map("n", "<leader>m", "<cmd>Grapple toggle<cr>", { desc = "Tag file" })
map("n", "<leader>M", "<cmd>Grapple toggle_tags<cr>", { desc = "Tags Menu" })

for i = 1, 9 do
  map("n", "<M-" .. i .. ">", function() require("grapple").select({ index = i }) end, { desc = "Select tag " .. i })
end

-- Autocommands

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- auto-detect and enable all server configs in 'lua/lsp/'
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file) return vim.fn.fnamemodify(file, ":t:r") end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})

-- auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})
