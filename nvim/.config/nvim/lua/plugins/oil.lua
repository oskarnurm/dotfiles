return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open Parent Directory" }),
  },
}
