return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>tz", function()
      require("zen-mode").setup {
        window = {
          width = 90,
          options = {},
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = true
      vim.wo.rnu = true
    end, { desc = "Zen mode" })

    vim.keymap.set("n", "<leader>tZ", function()
      require("zen-mode").setup {
        window = {
          width = 80,
          options = {},
        },
      }
      require("zen-mode").toggle()
      vim.wo.wrap = false
      vim.wo.number = false
      vim.wo.rnu = false
      vim.opt.colorcolumn = "80"
    end, { desc = "Zen mode pretty" })
  end,
}
