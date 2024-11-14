-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- windows
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split right', remap = true })
vim.keymap.set('n', '<leader>wq', '<C-W>c', { desc = '[q]uit window', remap = true })

--  Use <leader>+<arrow keys> to switch between windows
vim.keymap.set('n', '<leader><Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader><Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader><Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader><Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

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

-- Move a block of text up/down in visual mode using <shift>+arrow keys
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Up>', ":m '<-2<CR>gv=gv")

-- Delete to the void
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')

-- Change without yanking
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])
vim.keymap.set({ 'n', 'v' }, 'C', [["_C]])

-- Paste without yanking
vim.keymap.set('x', 'p', [["_dP]])

-- Launch tmux-sessionizer on CTRL+f
vim.keymap.set('n', '<C-f>', ":silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>", { silent = true })

-- Search and replace helper
vim.keymap.set('n', '<leader>fr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })
