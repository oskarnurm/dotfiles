return {
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    config = function()
      require("jb").setup({ transparent = false })
    end,
  },
  {
    "p00f/alabaster.nvim",
    lazy = false,
  },
  {
    dir = "~/odin/chiefdog.nvim/",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd("colorscheme chiefdog")
    end,
  },
  {
    "vague-theme/vague.nvim",
    lazy = false,
    config = function()
      require("vague").setup({ transparent = false })
      -- vim.cmd("colorscheme vague")
      vim.cmd(":hi statusline guibg=NONE")
    end,
  },
}
