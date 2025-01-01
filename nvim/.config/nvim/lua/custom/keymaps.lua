local custom = require 'custom.functions'

-- Lsp
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
-- vim.keymap.set('n', 'cr', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
-- vim.keymap.set('n', 'cx', vim.lsp.buf.code_action, { desc = 'Code Action' })
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find References' })
-- vim.keymap.set('n', 'ch', vim.lsp.buf.signature_help, { desc = 'Signature Help' })

-- Buffers
vim.keymap.set('n', '[b', ':bprev<cr>')
vim.keymap.set('n', ']b', ':bnext<cr>')

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

-- Completion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { desc = 'Omni complete' })

-- Quality of life
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })
vim.keymap.set('n', 'q', '<Nop>', { desc = 'Disable macro recording' })
vim.keymap.set('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and [R]eplace' })

-- Center screen on search
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
vim.keymap.set('n', '<leader><Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader><Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader><Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader><Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Windows
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Scripts
vim.keymap.set('n', '<C-f>', ":silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>", { silent = true, desc = 'tmux-sessionizer' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = '[X]ecutable file' })
vim.keymap.set('n', '<M-t>', function()
  custom.tmux_pane_function()
end, { desc = '[T]oggle tmux split' })
