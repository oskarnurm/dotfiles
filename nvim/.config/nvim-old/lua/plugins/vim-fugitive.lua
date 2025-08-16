return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>hg", "<cmd>Gvdiffsplit!<CR>", { desc = "Open Diffsplit" })
    vim.keymap.set("n", "<leader>hl", "<cmd>diffget //2<CR>", { desc = "Get Diff From 2" })
    vim.keymap.set("n", "<leader>hr", "<cmd>diffget //3<CR>", { desc = "Get Diff From 3" })
  end,
}
