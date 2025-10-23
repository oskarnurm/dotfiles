return {
  "nvim-mini/mini.nvim",
  config = function()
    require("mini.pick").setup()
    require("mini.extra").setup()
    require("mini.git").setup()
    vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>")
    vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<CR>")
    vim.keymap.set("n", "<leader>m", "<cmd>Pick help<CR>")
    vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>")
    vim.keymap.set("n", "<leader>k", "<cmd>Pick keymaps<CR>")
    vim.keymap.set("n", "<leader>s", '<cmd>Pick lsp scope="document_symbol"<CR>', { desc = "Pick symbols" })
    vim.keymap.set("n", "<leader>/", '<cmd>Pick buf_lines scope="current"<CR>', { desc = "Pick buffer" })
    vim.keymap.set("n", "<leader>:", "<cmd>Pick history<CR>")
    vim.keymap.set("n", "<leader>.", "<cmd>Pick oldfiles<CR>")
    vim.keymap.set("n", "<leader>n", function()
      require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } })
    end, { desc = "Pick config" })
  end,
}
