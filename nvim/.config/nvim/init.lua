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
o.scrolloff = 10
o.number = true
o.relativenumber = true
o.cursorline = true
o.splitright = true
o.splitbelow = true
o.termguicolors = true
o.signcolumn = "yes"
o.winborder = "single"
o.pumborder = "single"
o.list = true -- show tabs, trailing spaces and blanks
o.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.lsp.document_color.enable(true, 0, { style = "virtual" }) -- virtual style LSP support for highlighting color references in a document
vim.diagnostic.config({ virtual_text = true, underline = false })
o.wildoptions = "pum"

-- editing
o.wrap = false
o.expandtab = true -- convert tabs to spaces
o.tabstop = 2 -- size of tab
o.shiftwidth = 0 -- size of indentation (0 = size of tabstop)
o.smartcase = true
o.ignorecase = true
o.smartindent = true
o.inccommand = "split" -- preview substitutions live
o.virtualedit = "block"
o.spelloptions = "camel" -- treat camelCase word parts as separate words
o.grepprg = "git grep -n"
o.grepformat = "%f:%l:%m"
o.iskeyword = "@,48-57,_,192-255,-" -- treat dash as `word` textobject part
o.wildmode = "noselect:lastused,full"
o.completeopt = "menuone,noinsert,preview,fuzzy" -- buffer matches are sorted by time last used

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
  "https://github.com/mbbill/undotree.git",
  "https://github.com/folke/snacks.nvim.git",
  "https://github.com/stevearc/oil.nvim.git",
  "https://github.com/tpope/vim-fugitive.git",
  "https://github.com/nvim-mini/mini.nvim.git",
  "https://github.com/cbochs/grapple.nvim.git",
  "https://github.com/mason-org/mason.nvim.git",
  "https://github.com/folke/which-key.nvim.git",
  "https://github.com/stevearc/conform.nvim.git",
  "https://github.com/lewis6991/gitsigns.nvim.git",
  "https://github.com/rafamadriz/friendly-snippets.git",
  "https://github.com/nvim-treesitter/nvim-treesitter.git",
  "https://github.com/christoomey/vim-tmux-navigator.git",
  { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") },
})

vim.opt.runtimepath:prepend("~/odin/chiefdog.nvim")
vim.cmd("colorscheme chiefdog")
-- Setup
require("mason").setup()
require("mini.ai").setup()
require("mini.surround").setup()
require("oil").setup({ view_options = { show_hidden = true } })
require("grapple").setup({ scope = "git_branch", icons = false })
require("which-key").setup({ preset = "helix", icons = { mappings = false } })

require("snacks").setup({
  indent = { enabled = true },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
})

require("blink.cmp").setup({
  keymap = {
    ["<CR>"] = { "accept", "fallback" },
    ["<C-\\>"] = { "hide", "fallback" },
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<C-n>"] = { "select_next", "show" },
    ["<C-p>"] = { "select_prev" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
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
})

-- Mappings
local map = vim.keymap.set

-- quality of life
map({ "n", "v", "x" }, ";", ":")
map({ "n", "v", "x" }, ":", ";")
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "c", [["_c]])
map({ "n", "v" }, "C", [["_C]])
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("t", "<Esc><Esc>", "<C-\\><C-n>") -- TODO: remove if never use terminal

-- location & quickfix list
map("n", "<C-n>", "<cmd>cnext<CR>zz")
map("n", "<C-p>", "<cmd>cprev<CR>zz")
map("n", "<leader>q", "<cmd>copen<CR>")
map("n", "<leader>Q", "<cmd>cclose<CR>")
map("n", "<leader>l", "<cmd>lopen<CR>")
map("n", "<leader>L", "<cmd>lclose<CR>")

-- move lines
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

-- file navigation
-- map("n", "<leader>b", ":ls<CR>:b ", { desc = "Show Buffers" })
map("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
map("n", "<leader>av", "<cmd>vert sf #<CR>", { desc = "Alternative File Split" })
map("n", "<leader>b", ":b ", { desc = "Show Buffers" })
map("n", "<leader>g", ":copen | :silent :grep! ", { desc = "Grep" })

-- better find
vim.cmd([[
  set wildcharm=<C-z> " set Ctrl-z to trigger wildmenu completion
  let s:cache = [] " use cached results to avoid calling fd again on every keystroke
  
  func! FindFiles(cmdarg, cmdcomplete)
    if empty(s:cache) " only run fd if the cachce is empty
      let s:cache = systemlist('fd --type f --hidden --exclude .git')
    endif
     " return filtered copy of cache to allow backtracking
    return copy(s:cache)->filter('v:val =~? a:cmdarg')
  endfunc

  set findfunc=FindFiles
  
  " clear cache when leaving the command line (exiting search)
  " this ensures we get fresh results next time we call find
  augroup FindFilesCache
    autocmd!
    autocmd CmdlineLeave : let s:files_cache = []
  augroup END
  
  " automatically call Ctrl-z to force the menu to update as you filter the list
  augroup AutoWildmenuFind
    autocmd!
    autocmd CmdlineChanged : if getcmdline() =~ '^find \S' && !wildmenumode() | call feedkeys("\<C-z>", 'n') | endif
  augroup END
  
  "nnoremap <leader>f :find<C-z><Space>
]])
map("n", "<leader>f", ":find<C-z><Space>")

-- plugin specific
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
map("n", "<leader>o", "<cmd>Oil<CR>")

-- picker
---@diagnostic disable: undefined-global
map("n", "<leader>sf", function() Snacks.picker.files() end, { desc = "Files" })
map("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sc", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Neovim" })
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
map(
  "n",
  "<leader>/",
  function() Snacks.picker.lines({ layout = { preset = "select" } }) end,
  { desc = "Search Buffer" }
)

-- toggles
local t = Snacks.toggle
t.dim():map("<leader>tm")
t.indent():map("<leader>ti")
t.treesitter():map("<leader>tT")
t.diagnostics():map("<leader>td")
t.line_number():map("<leader>tl")
t.inlay_hints():map("<leader>th")
t.option("wrap", { name = "Wrap" }):map("<leader>tw")
t.option("spell", { name = "Spelling" }):map("<leader>ts")
t.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
t.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>tb")
t.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")

-- grapple
map("n", "<leader>m", "<cmd>Grapple toggle<cr>", { desc = "Tag file" })
map("n", "<leader>M", "<cmd>Grapple toggle_tags<cr>", { desc = "Tags Menu" })
for i = 1, 9 do
  map("n", "<M-" .. i .. ">", function() require("grapple").select({ index = i }) end, { desc = "Select tag " .. i })
end

-- gitsigns
require("gitsigns").setup({
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

-- Autocommands
-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
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
  group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("WrapSpell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then return end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})
