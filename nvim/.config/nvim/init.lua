vim.loader.enable()

local o = vim.opt
local g = vim.g
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = " "

-- general
o.mouse = "a"
o.confirm = true
o.undofile = true
o.swapfile = false
o.updatetime = 250
o.timeoutlen = 300

-- ui
o.rnu = true
o.number = true
o.scrolloff = 10
o.cursorline = true
o.splitright = true
o.splitbelow = true
o.termguicolors = true
o.signcolumn = "yes"
o.winborder = "single"
o.pumborder = "single"
o.pumheight = 20
o.list = true -- show tabs, trailing spaces and blanks
o.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.lsp.document_color.enable(true, 0, { style = "virtual" })
vim.diagnostic.config({ virtual_text = true, underline = false })

-- editing
o.wrap = false
o.expandtab = true -- convert tabs to spaces
o.tabstop = 2 -- size of tab
o.shiftwidth = 2 -- size of indentation
o.smartcase = true
o.ignorecase = true
o.smartindent = true
o.inccommand = "split" -- preview substitutions live
o.virtualedit = "block" -- allow virtual editing in visual block mode
o.spelloptions = "camel" -- treat camelCase word parts as separate words
o.iskeyword = "@,48-57,_,192-255,-" -- treat dash as `word` textobject part
o.wildmode = "noselect:lastused,full"
o.completeopt = "menuone,noinsert,preview,fuzzy" -- buffer matches are sorted by time last used
o.grepprg = "rg --vimgrep" -- TODO: maybe I should set ignore files explicitly...

-- avoid increasing startup-time
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- some useful autocmnds
vim.cmd([[
augroup init
  autocmd!
  autocmd BufNewFile * autocmd BufWritePre <buffer> ++once call mkdir(expand('%:h'), 'p')
  autocmd FileType text,plaintex,typst,gitcommit,markdown setlocal wrap spell
  autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup="Visual"} 
  autocmd CmdlineChanged [:\/\?] call wildtrigger()
  autocmd FileType * setlocal formatoptions-=c formatoptions-=o
augroup END
]])

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

-- LSP: auto-detect and enable all server configs in 'lua/lsp/'
autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file) return vim.fn.fnamemodify(file, ":t:r") end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})

-- plugins
vim.cmd.packadd("cfilter")
vim.pack.add({
  "https://github.com/mbbill/undotree.git",
  "https://github.com/stevearc/oil.nvim.git",
  "https://github.com/folke/which-key.nvim.git",
  "https://github.com/stevearc/conform.nvim.git",
  "https://github.com/lewis6991/gitsigns.nvim.git",
  "https://github.com/nvim-mini/mini.indentscope.git",
  "https://github.com/rafamadriz/friendly-snippets.git",
  "https://github.com/nvim-treesitter/nvim-treesitter.git",
  "https://github.com/christoomey/vim-tmux-navigator.git",
  { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") },
})

vim.opt.runtimepath:prepend("~/odin/chiefdog.nvim")
vim.cmd("colorscheme chiefdog")

-- setup
require("blink.cmp").setup()
require("mini.indentscope").setup() -- nice to have sometimes
require("oil").setup({ view_options = { show_hidden = true } })
require("which-key").setup({ preset = "helix", icons = { mappings = false } })

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

-- keymaps
-- plugin specific
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
map("n", "<leader>o", "<cmd>Oil<CR>")

-- quality of life
map({ "n", "v", "x" }, ";", ":")
map({ "n", "v", "x" }, ":", ";")
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "c", [["_c]])
map({ "n", "v" }, "C", [["_C]])
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>td", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Diagnostics" })

-- location & quickfix list
map("n", "<C-n>", "<cmd>cnext<CR>zz")
map("n", "<C-p>", "<cmd>cprev<CR>zz")
map("n", "<leader>l", "<cmd>lclose<CR>") -- almost always only need to close the location list
map("n", "<leader>q", function() -- toggle quickfix list
  local qf_exists = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(qf_exists and "cclose" or "copen")
end, { desc = "Quickfix Toggle" })

-- move lines
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")

-- files n' stuff
map("n", "<leader>sa", "<cmd>vert sf #<CR>", { desc = "Split Alt File" })
map("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
map("n", "<leader>e", "<cmd>e $MYVIMRC<CR>")
map("n", "<leader>b", ":buffer ")
map("n", "<leader>f", ":find ")
map("n", "<leader>g", ":Grep ")

-- enhance the :find command with fd, fuzzy file completion and auto-selection, see :h fuzzy-file-picker
local filescache = {}
function _G.FindFiles(arg, _)
  if #filescache == 0 then filescache = vim.fn.systemlist("fd --type f --follow --hidden --exclude .git") end
  return #arg == 0 and filescache or vim.fn.matchfuzzy(filescache, arg)
end
vim.o.findfunc = "v:lua.FindFiles"
autocmd({ "CmdlineLeave", "CmdlineLeavePre" }, {
  pattern = ":",
  callback = function(ev)
    if ev.event == "CmdlineLeavePre" then
      local info = vim.fn.cmdcomplete_info()
      if info.matches and #info.matches > 0 then
        if vim.fn.getcmdline():match("^%s*fin[d]?%s") and info.selected == -1 then
          vim.fn.setcmdline("find " .. info.matches[1])
        end
      end
    elseif ev.event == "CmdlineLeave" then
      filescache = {}
    end
  end,
})

-- grep with live updating quickfix list
autocmd("CmdlineChanged", {
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
