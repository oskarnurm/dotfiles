return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  opts = {
    notify_on_error = true,
    format_on_save = {
      lsp_format = 'fallback',
      timeout_ms = 500,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      python = { 'isort', 'black', 'autopep8', 'prettier' },
      sh = { 'shfmt' },
      fish = { 'fish_indent' },
      -- Other
      ['_'] = { 'prettier' },
    },
  },
}
