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
    "vague-theme/vague.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("vague").setup({ transparent = false })
      -- vim.cmd("colorscheme vague")
      vim.cmd(":hi statusline guibg=NONE")
    end,
  },
}
