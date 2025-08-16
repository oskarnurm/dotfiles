return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "folke/lazydev.nvim",
  },
  opts = {
    keymap = { preset = "default" },

    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = false },
    },
    sources = {
      default = { "lsp", "path", "snippets", "lazydev", "buffer" },
      providers = {
        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },

    signature = { enabled = false },
  },
}
