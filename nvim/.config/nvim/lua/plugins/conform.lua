return {
  "stevearc/conform.nvim",
  event = "LazyFile",
  opts = {
    format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      html = { "prettierd" },
      python = { "ruff_format" },
      sh = { "shfmt" },
      java = { "google-java-format" },
      ["_"] = { "prettierd" },
    },
  },
}
