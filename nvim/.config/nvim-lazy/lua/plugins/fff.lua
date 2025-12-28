return {
  "dmtrKovalenko/fff.nvim",
  enabled = true,
  build = function()
    -- this will download prebuild binary or try to use existing rustup toolchain to build from source
    -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  opts = { prompt = "> " },
  keys = {
    {
      "<leader>sf",
      function()
        require("fff").find_files()
      end,
      desc = "FFFind files",
    },
  },
}
