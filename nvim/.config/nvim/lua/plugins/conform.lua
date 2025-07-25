return {
  "stevearc/conform.nvim",
  event = "LazyFile",
  opts = {
    notify_on_error = true,
    format_on_save = {
      lsp_format = "fallback",
      timeout_ms = 1000,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      python = { "isort", "black" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      html = { "prettier" },
      java = { "google-java-format" },
      yaml = { "yamlfmt" },
      -- Other
      ["_"] = { "prettier" },
    },
  },
}
