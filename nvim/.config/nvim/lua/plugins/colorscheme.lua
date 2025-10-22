return {
  {
    "nickkadutskyi/jb.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("jb").setup({ transparent = true })
      vim.cmd("colorscheme jb")
      -- vim.cmd(":hi statusline guibg=NONE")
    end,
  },
}
