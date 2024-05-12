return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup {
        transparent_mode = true,
      }
      vim.cmd "colorscheme gruvbox"
    end,
  },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("github-theme").setup {
  --       options = {
  --         transparent = true, -- Disable setting background
  --       },
  --     }
  --     -- vim.cmd "colorscheme github_dark_high_contrast"
  --   end,
  -- },
}
