return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- dependencies = { 'echasnovski/mini.icons' },
    config = function()
      local fzf = require 'fzf-lua'
      local map = function(mode, keys, func, desc)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { desc = desc })
      end
      -- Files
      map('n', '<leader>ff', fzf.files, 'FZF Files')
      map('n', '<leader><leader>', fzf.buffers, 'FZF Buffers')
      map('n', '<leader>fr', fzf.registers, 'Registers')
      map('n', '<leader>fk', fzf.keymaps, 'Keymaps')
      map('n', '<leader>fg', fzf.live_grep, 'FZF Grep')
      map('n', '<leader>fw', fzf.grep_cword, 'FZF Word')
      map('n', '<leader>fh', fzf.helptags, 'Help Tags')
      map('n', '<leader>fn', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, '[F]ind [N]eovim')

      -- LPS
      map('n', '<leader>gr', fzf.lsp_references, 'Goto References')
      map('n', '<leader>fd', fzf.diagnostics_document, 'Document Diagnostics')
      map('n', '<leader>fD', fzf.diagnostics_document, 'Workspace Diagnostics')
      map('n', '<leader>ca', fzf.lsp_code_actions, 'Code Actions')
      map('n', '<leader>fs', fzf.lsp_document_symbols, 'Document Symbols')
      map('n', '<leader>fS', fzf.lsp_workspace_symbols, 'Workspace Symbols')
    end,
  },
}
