return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    icons = { mappings = false },
    spec = {
      { "<leader>s", group = "Search/Subsitute" },
      { "<leader>f", group = "Find" },
      { "<leader>t", group = "Toggle" },
      -- { "<leader>g", group = "Git" },
      { "gr", group = "Goto" },
      { "<leader>h", group = "Hunk", mode = { "n", "v" } },
    },
  },
}
