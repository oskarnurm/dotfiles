return {
  {
    'folke/trouble.nvim',
    opts = {
      focus = true,
    },
    cmd = 'Trouble',
    keys = {
      {
        '<leader>tT',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Workspace Diagnostics',
      },
      {
        '<leader>tt',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Toggle Symbols',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'Toggle LSP Definitions / references / ...',
      },
      {
        '<leader>tl',
        '<cmd>Trouble loclist toggle<cr>',
        desc = '[L]ocation List',
      },
      {
        '<leader>tq',
        '<cmd>Trouble qflist toggle<cr>',
        desc = '[Q]uickfix List (Trouble)',
      },
    },
  },
}
