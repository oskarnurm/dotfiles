return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    tailwind = true,
    tailwind_opts = {
      update_names = true,
    },
  },
}
