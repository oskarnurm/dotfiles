vim.loader.enable()

-- General
vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.confirm = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.swapfile = false
vim.opt.undofile = true
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "bold"
vim.opt.pumborder = "bold"
vim.opt.scrolloff = 999
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.lsp.document_color.enable(true, 0, { style = "virtual" })

local diagnostic_opts = {
  signs = { priority = 9999, severity = { min = "WARN", max = "ERROR" } },
  underline = { severity = { min = "HINT", max = "ERROR" } },
  virtual_lines = false,
  virtual_text = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
  },
  update_in_insert = false,
}
vim.schedule(function() vim.diagnostic.config(diagnostic_opts) end)

-- Editing
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.completeopt = "menuone,noinsert,preview,fuzzy"
vim.opt.iskeyword = "@,48-57,_,192-255,-"
vim.opt.grepprg = "rg --vimgrep"

-- Plugins
-- lazyloading: https://github.com/neovim/neovim/issues/35303
-- Benchmark with `=MiniMisc.stat_summary(MiniMisc.bench_time(vim.cmd, 1000, 'colorscheme koda'))`
vim.opt.runtimepath:prepend("~/odin/koda.nvim")
vim.pack.add({
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})

require("koda").setup()
vim.cmd("colorscheme koda")

require("mini.ai").setup()
require("mini.pick").setup()
require("mini.extra").setup()
require("mini.git").setup()
require("mini.diff").setup({
  view = {
    style = "sign",
    signs = { add = "+", change = "~", delete = "_" },
  },
  mappings = { reset = "gr" },
})
-- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
-- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
-- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
-- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
-- - `shf`   - *s*urround *h*ighlight current *f*unction call
-- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
-- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
-- - `vaWsa<Space>` - *v*isually select *a*round *W*ORD and *s*urround *a*dd
--                    spaces (`<Space>`)
require("mini.surround").setup()

require("blink.cmp").setup()
require("oil").setup({ view_options = { show_hidden = true } })
require("which-key").setup({ preset = "helix", icons = { mappings = false } })
require("conform").setup({
  format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
  formatters_by_ft = {
    sh = { "shfmt" },
    lua = { "stylua" },
    python = { "ruff_format" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    c = { lsp_format = "prefer" },
    java = { lsp_format = "prefer" },
    ["_"] = { "prettierd" },
  },
})

-- Keymaps
vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("n", "<leader>sa", "<cmd>vert sf #<CR>", { desc = "Split Alt File" })
vim.keymap.set("n", "<leader>b", ":buffer ")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")

vim.keymap.set("n", "<leader>k", function()
  vim.cmd("KodaFetch")
  if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then vim.cmd("lsp restart") end
end)

vim.keymap.set("n", "<leader>q", function()
  local qf_exists = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(qf_exists and "cclose" or "copen")
end, { desc = "Quickfix Toggle" })

vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>m", "<cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>Pick git_hunks<CR>")
vim.keymap.set(
  "n",
  "<leader>n",
  function() require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } }) end
)

-- Trigger wildmenu for command-line modes
vim.api.nvim_create_autocmd("CmdlineChanged", {
  group = vim.api.nvim_create_augroup("TriggerWildmenu", { clear = true }),
  pattern = { ":", "/", "?" },
  callback = function() vim.cmd([[ setlocal pumheight=15 | call wildtrigger()]]) end,
})

-- Auto-select first match
vim.api.nvim_create_autocmd("CmdlineLeavePre", {
  group = vim.api.nvim_create_augroup("AutoSelectFind", { clear = true }),
  pattern = ":",
  callback = function()
    local info = vim.fn.cmdcomplete_info()
    if info.matches and #info.matches > 0 and info.selected == -1 then
      local cmd = vim.fn.getcmdline()
      if cmd:match("^find") then vim.fn.setcmdline("find " .. info.matches[1]) end
      if cmd:match("^buffer") then vim.fn.setcmdline("buffer " .. info.matches[1]) end
      if cmd:match("^e") then vim.fn.setcmdline("e " .. info.matches[1]) end
    end
  end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HlYank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Don't automatically insert the current comment leader after hitting 'o'
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("WrapSpell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Create missing parent directories automatically
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("AutoCreateDir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LastLoc", { clear = true }),
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

-- Auto-detect and enable all server configs in 'lua/lsp/'
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

-- Automatically install and enable treesitter parsers
local TS = require("nvim-treesitter")
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TSAutoInstall", { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    if not lang then return end
    local has_parser = #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0
    if has_parser then
      vim.treesitter.start(ev.buf)
    else
      TS.install({ lang })
    end
  end,
})
