vim.loader.enable()
vim.g.mapleader = " "

vim.cmd([[let &stc = '%s %5l ']])
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.spell = true
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
  "https://github.com/vague2k/vague.nvim",
  "https://github.com/mbbill/undotree",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/nvim-mini/mini.nvim",
})

require("marks")
require("statusline")
require("mason").setup()
require("mini.pick").setup()
require("which-key").setup()
require("nvim-ts-autotag").setup()
require("blink.cmp").setup({ completion = { documentation = { auto_show = true } } })
require("oil").setup({ view_options = { show_hidden = true } })
require("blink.cmp").setup({ completion = { menu = { auto_show = false }, documentation = { auto_show = true } } })
require("which-key").setup({ preset = "helix", icons = { mappings = false } })

require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})

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
vim.keymap.set("n", "[[", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]]", "<cmd>cnext<CR>zz")
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
vim.keymap.set({ "o", "x" }, "ih", "<cmd>Gitsigns select_hunk<CR")
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<CR>")
map("n", "<leader><space>", "<cmd>Pick buffers<CR>")
map("n", "<leader>ff", "<cmd>Pick files<CR>")
map("n", "<leader>fh", "<cmd>Pick help<CR>")
map("n", "<leader>fg", "<cmd>Pick grep_live<CR>")
map("n", "<leader>fk", "<cmd>Pick keymaps<CR>")
map("n", "<leader>fs", '<cmd>Pick lsp scope="document_symbol"<CR>', { desc = "Pick symbols" })
map("n", "<leader>/", '<cmd>Pick buf_lines scope="current"<CR>', { desc = "Pick buffer" })
map("n", "<leader>:", "<cmd>Pick history<CR>")
map("n", "<leader>.", "<cmd>Pick oldfiles<CR>")
map(
  "n",
  "<leader>fn",
  "<cmd>lua MiniPick.builtin.files({}, { source = { cwd = vim.fn.stdpath('config') } })<CR>",
  { desc = "Pick config" }
)
