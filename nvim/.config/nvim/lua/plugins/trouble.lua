return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {
    focus = true, -- Add this line to focus the Trouble window when opened
  },
  keys = {
    { '<leader>td', '<cmd>Trouble diagnostics toggle<cr>', desc = '[d]iagnostics (Trouble)' },
    { '<leader>tD', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer [D]iagnostics (Trouble)' },
    { '<leader>ts', '<cmd>Trouble symbols toggle<cr>', desc = '[s]ymbols (Trouble)' },
    { '<leader>tS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
    { '<leader>tL', '<cmd>Trouble loclist toggle<cr>', desc = '[L]ocation List (Trouble)' },
    { '<leader>tQ', '<cmd>Trouble qflist toggle<cr>', desc = '[Q]uickfix List (Trouble)' },
  },
}
