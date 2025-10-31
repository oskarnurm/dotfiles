return {
  "nickkadutskyi/jb.nvim",
  "y9san9/y9nika.nvim",
  "vague-theme/vague.nvim",
  "p00f/alabaster.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    require("jb").setup({ transparent = true })
    require("vague").setup({ transparent = true })
    -- vim.cmd(":hi statusline guibg=NONE")
  end,
}
