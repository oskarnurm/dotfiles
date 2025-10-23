return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = { view_options = { show_hidden = true } },
  vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>"),
}
