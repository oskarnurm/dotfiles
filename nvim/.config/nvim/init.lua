vim.loader.enable()
vim.g.mapleader = " "
require("autocmds")
require("marks")
require("statusline")

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
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.diagnostic.config({ virtual_text = true, underline = false })
vim.lsp.document_color.enable(true, 0, { style = "virtual" })
vim.lsp.config("*", { root_makers = { ".git" } })
vim.lsp.enable({ "ts_ls", "tsgo", "cssls", "html", "tailwindcss", "lua_ls", "jdtls", "basedpyright", "clangd" })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/mbbill/undotree" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
  { src = "https://github.com/oskarnurm/mini.pick" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
})

require("mason").setup()
require("mini.pick").setup()
require("gitsigns").setup()
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

vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[[", "<cmd>cprev<CR>")
vim.keymap.set("n", "]]", "<cmd>cnext<CR>")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "grd", vim.lsp.buf.definition)
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("n", "<leader>q", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Toggle quickfix" })

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
vim.keymap.set("v", "<leader>hs", function()
  require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "Stage hunk" })

vim.keymap.set("n", "<space><space>", "<cmd>Pick buffers<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files tool='fd'<CR>")
vim.keymap.set("n", "<leader>fr", "<cmd>Pick resume<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<leader>fn", function()
  require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } })
end, { desc = "Pick config" })
