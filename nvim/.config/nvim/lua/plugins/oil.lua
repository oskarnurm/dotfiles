return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    lazy = false,
    vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open Parent Directory" }),
  },
}
