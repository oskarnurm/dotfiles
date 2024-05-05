return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["z"] = { name = "+fold" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+find/file" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>w"] = { name = "+workspace" },
      ["<leader>r"] = { name = "+rename" },
      ["<leader>d"] = { name = "+document" },
    },
  },
  config = function(_, opts)
    local wk = require "which-key"
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
