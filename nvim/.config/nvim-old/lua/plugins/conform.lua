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
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      python = { "isort", "black" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
      html = { "prettierd" },
      java = { "google-java-format" },
      yaml = { "yamlfmt" },
      -- Other
      ["_"] = { "prettierd" },
    },
  },
}
