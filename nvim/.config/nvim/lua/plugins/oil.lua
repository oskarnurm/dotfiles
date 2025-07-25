return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open Parent Directory" }),
  },
}
