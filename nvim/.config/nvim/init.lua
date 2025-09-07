vim.loader.enable()
vim.g.mapleader = " "

vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.spell = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.wrap = false
vim.o.confirm = true
vim.o.swapfile = false
vim.o.undofile = true
vim.o.inccommand = "split"
vim.o.virtualedit = "block"
vim.o.signcolumn = "yes"
vim.o.completeopt = "menuone,noinsert,preview"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.list = true
vim.o.winborder = "single"
-- vim.o.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.diagnostic.config({ virtual_text = true, underline = false })

vim.lsp.config("*", { root_makers = { ".git" } })
vim.lsp.enable({ "ts_ls", "tsgo", "cssls", "html", "tailwindcss", "lua_ls", "jdtls", "basedpyright", "clangd" })

require("lsp")
require("autocmds")
require("statusline")
require("marks")

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

require("mason").setup()
require("mini.pick").setup()
require("mini.extra").setup()
require("nvim-ts-autotag").setup()
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
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function()
      gs.nav_hunk("next")
    end, { desc = "Next Hunk" })
    map("n", "[h", function()
      gs.nav_hunk("prev")
    end, { desc = "Previous Hunk" })

    -- Visual
    map("v", "<leader>hs", function()
      gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage hunk" })
    map("v", "<leader>hr", function()
      gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset hunk" })

    -- Normal
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
    map("n", "<leader>hb", gs.blame_line, { desc = "Blame Line" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Blame Line" })

    -- Text object
    map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Hunk" })
  end,
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

local lint = require("lint")
lint.linters_by_ft = {
  markdown = { "markdownlint" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

-- Create autocommand which carries out the actual linting
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
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
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "<c-v>",
      },
      include_surrounding_whitespace = true,
    },
  },
})

local map = vim.keymap.set
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "c", [["_c]])
map({ "n", "v" }, "C", [["_C]])
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "[[", "<cmd>cprev<CR>zz")
map("n", "]]", "<cmd>cnext<CR>zz")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "J", ":m '>+1<CR>gv=gv")
map("n", "grd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
map("n", "<leader>q", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Toggle quickfix" })

map("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
map("n", "<leader>o", "<cmd>Oil<CR>")
map("n", "<leader>gc", "<cmd>Git commit<CR>")

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
