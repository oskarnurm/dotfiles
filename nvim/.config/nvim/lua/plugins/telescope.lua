return {
  enabled = true,
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    }
    require('telescope').load_extension 'fzf'

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[F]iles' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>sD', builtin.diagnostics, { desc = 'Workspace [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.oldfiles, { desc = '[R]ecent' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Open Buffers' })
    vim.keymap.set('n', '<leader>sd', function()
      builtin.diagnostics { bufnr = 0 }
    end, { desc = '[D]iagnostics' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[N]eovim files' })
  end,
}
