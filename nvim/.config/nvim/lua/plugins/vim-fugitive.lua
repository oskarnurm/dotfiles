return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  init = function()
    vim.keymap.set("n", "<leader>hs", "<cmd>Git<CR>", { desc = "Git status" })
    vim.keymap.set("n", "<leader>hw", "<cmd>Gwrite<CR>", { desc = "Stage current file" })

    vim.keymap.set("n", "<leader>hd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff" })
    vim.keymap.set("n", "<leader>he", "<cmd>only<CR>", { desc = "Exit vimdiff" })

    vim.keymap.set("n", "<leader>hl", "<cmd>diffget //2<CR>", { desc = "Get left (Merge conflict)" })
    vim.keymap.set("n", "<leader>hr", ":<cmd>diffget //3<CR>", { desc = "Get right (Merge conflict)" })
  end,
}
