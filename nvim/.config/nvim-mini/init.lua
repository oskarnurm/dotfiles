vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes:1"
vim.opt.winborder = "bold"
vim.opt.pumborder = "bold"
vim.opt.scrolloff = 999
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.completeopt = "menuone,noinsert,preview,fuzzy"
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)
vim.lsp.document_color.enable(true, 0, { style = "virtual" })

vim.opt.runtimepath:prepend("~/odin/koda.nvim")
vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

vim.cmd("colorscheme koda")

require("oil").setup({ view_options = { show_hidden = true } })
require("conform").setup({
  format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
  formatters_by_ft = {
    sh = { "shfmt" },
    lua = { "stylua" },
    python = { "ruff_format" },
    c = { lsp_format = "prefer" },
    java = { "google-java-format" },
    ["_"] = { "prettierd" },
  },
})

vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "<C-space>", "<C-x><C-o>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>KodaFetch<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>q", function()
  local is_qf = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(is_qf and "cclose" or "copen")
end)
vim.keymap.set("n", "<leader>c", function()
  vim.ui.input({}, function(c)
    if c and c ~= "" then
      vim.cmd("noswapfile vnew")
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "wipe"
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
    end
  end)
end)

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function() vim.cmd([[ setlocal pumheight=15 | call wildtrigger()]]) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove({ "r", "o" }) end,
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

local TS = require("nvim-treesitter")
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buffer = args.buf
    local lang = args.match
    TS.install(lang):await(function()
      if not vim.api.nvim_buf_is_loaded(buffer) then return end
      local installed = TS.get_installed()
      if vim.list_contains(installed, lang) then vim.treesitter.start(buffer) end
      vim.bo[buffer].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end)
  end,
})
