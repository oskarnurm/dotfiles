vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- General settings
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
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "single"
vim.opt.pumborder = "single"
vim.opt.scrolloff = 10
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.diagnostic.config({ virtual_text = true, underline = false })
vim.lsp.document_color.enable(true, vim.api.nvim_get_current_buf(), { style = "virtual" })

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
vim.opt.iskeyword = "@,48-57,_,192-255,-" -- treat dash as `word` textobject part
vim.opt.grepprg = "rg --vimgrep --glob='!.git/*' --glob='!node_modules/*'"
vim.opt.formatoptions:remove("o") -- dont add comment after hitting 'o'

-- Plugins
-- NOTE: on lazyloading, see https://github.com/neovim/neovim/issues/35303
vim.cmd.packadd("cfilter")
vim.pack.add({
  "https://github.com/mbbill/undotree.git",
  "https://github.com/stevearc/oil.nvim.git",
  "https://github.com/tpope/vim-fugitive.git",
  "https://github.com/nvim-mini/mini.nvim.git",
  "https://github.com/folke/which-key.nvim.git",
  "https://github.com/stevearc/conform.nvim.git",
  "https://github.com/lewis6991/gitsigns.nvim.git",
  "https://github.com/rafamadriz/friendly-snippets.git",
  "https://github.com/christoomey/vim-tmux-navigator.git",
  "https://github.com/nvim-treesitter/nvim-treesitter.git",
  { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") },
})

vim.opt.runtimepath:prepend("~/odin/koda.nvim") -- while in dev
require("koda").setup()
vim.cmd("colorscheme koda")

require("mini.ai").setup()
require("mini.pick").setup()
require("mini.extra").setup()
require("blink.cmp").setup()
require("mini.files").setup()
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

-- Keymaps
vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("n", "<leader>sa", "<cmd>vert sf #<CR>", { desc = "Split Alt File" })
vim.keymap.set("n", "<leader>l", "<cmd>lclose<CR>")
vim.keymap.set("n", "<leader>c", "<cmd>e $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>b", ":buffer ")
vim.keymap.set("n", "<leader>f", ":find ")
vim.keymap.set("n", "<leader>g", ":Grep ")
vim.keymap.set("n", "<leader>k", function()
  vim.cmd("KodaFetch")
  if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then vim.cmd("lsp restart") end
end)
vim.keymap.set("n", "<leader>vg", ":lua print(vim.inspect(vim.pack.get()))<CR>")

-- Toggle quickfix list
vim.keymap.set("n", "<leader>q", function()
  local qf_exists = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(qf_exists and "cclose" or "copen")
end, { desc = "Quickfix Toggle" })

-- Toggle diagnostic list
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  local msg = vim.diagnostic.is_enabled() and "Enabled" or "Disabled"
  vim.notify("Diagnostics " .. msg)
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>tv", function()
  local enabled = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not enabled })
end, { desc = "Toggle virtual text" })

-- Enhance the :find command with `fd`, fuzzy file completion and auto-selection.
-- we store results from fd in cache once per call to optimize performance
-- TODO: add support for git files using `git ls-files` for example. Is it worth the added complexity? Maybe sometimes nicer if we can get to root faster
local filescache = {}
function _G.Find(arg, _)
  if #filescache == 0 then filescache = vim.fn.systemlist("fd --type f --follow --hidden --exclude .git") end
  return #arg == 0 and filescache or vim.fn.matchfuzzy(filescache, arg)
end
vim.o.findfunc = "v:lua.Find"
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function() filescache = {} end,
})

-- Trigger wildmenu for command-line modes
vim.api.nvim_create_autocmd("CmdlineChanged", {
  group = vim.api.nvim_create_augroup("TriggerWildmenu", { clear = true }),
  pattern = { ":", "/", "?" },
  callback = function() vim.cmd([[ setlocal pumheight=15 | call wildtrigger()]]) end,
})

-- Auto-select first match for :find
vim.api.nvim_create_autocmd("CmdlineLeavePre", {
  group = vim.api.nvim_create_augroup("AutoSelectFind", { clear = true }),
  pattern = ":",
  callback = function()
    local info = vim.fn.cmdcomplete_info()
    if info.matches and #info.matches > 0 then
      if vim.fn.getcmdline():match("^%s*fin[d]?%s") and info.selected == -1 then
        vim.fn.setcmdline("find " .. info.matches[1])
      end
    end
  end,
})

-- Auto-select first match for :buffer
vim.api.nvim_create_autocmd("CmdlineLeavePre", {
  group = vim.api.nvim_create_augroup("AutoSelectBuffers", { clear = true }),
  pattern = ":",
  callback = function()
    local info = vim.fn.cmdcomplete_info()
    if info.matches and #info.matches > 0 then
      if vim.fn.getcmdline():match("^%s*bu?f?f?e?r?%s") and info.selected == -1 then
        vim.fn.setcmdline("buffer " .. info.matches[1])
      end
    end
  end,
})

-- Live grep updates quickfix list as you type
-- create the 'Grep' user command to avoid errors
vim.api.nvim_create_user_command("Grep", "copen", { nargs = "*" })
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = ":",
  callback = function()
    local words = vim.split(vim.fn.getcmdline(), " ", { trimempty = true })
    if words[1] == "Grep" and #words > 1 then
      vim.cmd("silent grep! " .. vim.fn.escape(words[2], " "))
      vim.cmd("cwindow")
      vim.cmd.redraw()
    end
  end,
})

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
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

-- Wrap and check for spell in text filetypes
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
