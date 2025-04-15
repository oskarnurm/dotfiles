return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
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
      html = { "htmlbeautifier" },
      java = { "google-java-format" },
      -- Other
      ["_"] = { "prettier" },
    },
  },
}
