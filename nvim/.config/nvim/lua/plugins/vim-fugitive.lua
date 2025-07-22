return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  init = function()
    vim.keymap.set("n", "<leader>hgs", "<cmd>Git<CR>", { desc = "Status" })
    vim.keymap.set("n", "<leader>hgw", "<cmd>Gwrite<CR>", { desc = "Stage current file" })

    vim.keymap.set("n", "<leader>hgo", "<cmd>Gvdiffsplit<CR>", { desc = "Open diffsplit" })
    vim.keymap.set("n", "<leader>hge", "<cmd>only<CR>", { desc = "Exit diffsplit" })

    vim.keymap.set("n", "<leader>hgl", "<cmd>diffget //2<CR>", { desc = "Get left (Merge conflict)" })
    vim.keymap.set("n", "<leader>hgr", ":<cmd>diffget //3<CR>", { desc = "Get right (Merge conflict)" })
  end,
}
