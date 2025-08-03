return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open Parent Directory" }),
  },
}
