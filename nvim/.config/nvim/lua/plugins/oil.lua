return {
	"stevearc/oil.nvim",
	opts = {
		view_options = {
			show_hidden = true,
		},
	},
	vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "[O]pen directory" }),
	-- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
