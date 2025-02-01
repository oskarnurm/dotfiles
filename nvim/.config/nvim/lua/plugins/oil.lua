return {
  {
    'stevearc/oil.nvim',
    opts = {},
    lazy = false,
    vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = 'Open parent directory' }),
  },
}
