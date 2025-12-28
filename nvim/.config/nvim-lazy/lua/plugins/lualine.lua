return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "", "", "filetype" },
      lualine_y = { "" },
      lualine_z = { "location" },
    },
  },
}
