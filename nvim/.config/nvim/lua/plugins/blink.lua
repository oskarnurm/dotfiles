return {
  {
    enabled = true,
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*",
    opts = {
      keymap = { preset = "default" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        menu = { auto_show = true },
        documentation = { auto_show = false },
      },
    },
  },
}
