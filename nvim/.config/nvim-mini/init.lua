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
vim.opt.undodir = os.getenv("HOME") .. "/.neovim/undodir2"
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "yes"
vim.opt.completeopt = "menuone,noinsert,preview"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.list = true
vim.opt.winborder = "single"
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.diagnostic.config({ virtual_text = true, underline = false })
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[[", "<cmd>cprev<CR>")
vim.keymap.set("n", "]]", "<cmd>cnext<CR>")
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])

-- Quickfix toggle
vim.keymap.set("n", "<leader>q", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
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

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main", build = ":TSUpdate" }, -- no clue if the update thing works
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.6.0" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("mason").setup()
require("nvim-ts-autotag").setup()

require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

require("oil").setup({ view_options = { show_hidden = true } })
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>")

require("conform").setup({
	notify_on_error = true,
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 1000,
	},
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

require("blink.cmp").setup({
	completion = { accept = { auto_brackets = { enabled = false } } },
})
vim.lsp.enable({ "cssls", "html", "clangd", "tailwindcss", "jdtls", "basedpyright", "ts_ls", "lua_ls" })

require("nvim-treesitter.configs").setup({
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

require("mini.pick").setup()
vim.keymap.set("n", "<leader><space>", "<cmd>Pick buffers<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<CR>")

-- print(vim.inspect(vim.pack.get()))
