local custom = require 'config.utils'

-- Find
vim.keymap.set('n', '<leader>o', '<cmd>lua MiniFiles.open()<cr>', { desc = '[O]pen Files' })
vim.keymap.set('n', '<leader>ff', require('fzf-lua').files, { desc = 'FZF Files' })
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers, { desc = 'FZF Buffers' })
vim.keymap.set('n', '<leader>fr', require('fzf-lua').registers, { desc = 'Registers' })
vim.keymap.set('n', '<leader>fk', require('fzf-lua').keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fg', require('fzf-lua').live_grep, { desc = 'FZF Grep' })
vim.keymap.set('n', '<leader>fw', require('fzf-lua').grep_cword, { desc = 'FZF Word' })
vim.keymap.set('n', '<leader>fh', require('fzf-lua').helptags, { desc = 'Help Tags' })
vim.keymap.set('n', '<leader>fs', require('fzf-lua').spell_suggest, { desc = 'Spelling Suggestions' })
vim.keymap.set('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[S]earch and [R]eplace' })

-- LPS
vim.keymap.set('n', '<leader>gr', require('fzf-lua').lsp_references, { desc = 'Goto References' })
vim.keymap.set('n', '<leader>fd', require('fzf-lua').diagnostics_document, { desc = 'Document Diagnostics' })
vim.keymap.set('n', '<leader>fD', require('fzf-lua').diagnostics_document, { desc = 'Workspace Diagnostics' })
vim.keymap.set('n', '<leader>ca', require('fzf-lua').lsp_code_actions, { desc = 'Code Actions' })

-- Quickfix
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Prev [Q]uickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next [Q]uickfix' })
vim.keymap.set('n', '<leader>q', function()
  custom.toggle_quickfix()
end, { desc = 'Toggle [Q]quickfix' })

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Line [E]rrors' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnotsitc' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev [D]iagnostic' })

-- Quality of life
vim.keymap.set('n', '<Esc>', function()
  custom.clear_highlight_and_close_float()
end, { noremap = true, silent = true })
vim.keymap.set('n', 'q', '<Nop>', { desc = 'Disable macro recording' })

-- Center screen
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Better indenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Move a block of text up/down in visual mode
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Up>', ":m '<-2<CR>gv=gv")

-- Delete to the void
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')

-- Without yanking
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])
vim.keymap.set({ 'n', 'v' }, 'C', [["_C]])
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })
vim.keymap.set('x', '<leader>d', [["_dD]], { desc = 'Delete without yanking' })

-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- NOTE: I use ColemakDH on my ZSA Voyager with arrow keys mapped as a hjkl layer
vim.keymap.set('n', '<leader><Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader><Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader><Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader><Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Windows
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Tmux
vim.keymap.set('n', '<C-f>', "<cmd>silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>", { silent = true, desc = 'tmux-sessionizer' })
vim.keymap.set('n', '<M-t>', function()
  custom.tmux_pane_toggle()
end, { desc = '[T]oggle tmux split' })
