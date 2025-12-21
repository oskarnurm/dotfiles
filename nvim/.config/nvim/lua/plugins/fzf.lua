return {
  "ibhagwan/fzf-lua",
  config = function()
    require("fzf-lua").setup()
    vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Files" })
    vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<CR>", { desc = "Help" })
    vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Grep" })
    vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<CR>", { desc = "Keymaps" })
    vim.keymap.set("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Symbols" })
    vim.keymap.set("n", "<leader>/", "<cmd>FzfLua blines<CR>", { desc = "Search Buffer" })
    vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent" })
    vim.keymap.set("n", "<leader>fw", "<cmd>FzfLua grep_cword<CR>", { desc = "cWord" })
    vim.keymap.set("n", "<leader>fc", "<cmd>FzfLua colorschemes<CR>", { desc = "Colorschemes" })
    vim.keymap.set("n", "<leader>fn", function()
      require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Neovim" })
  end,
}
