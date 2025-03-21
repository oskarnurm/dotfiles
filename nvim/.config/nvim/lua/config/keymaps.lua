local custom = require 'config.utils'

-- completion
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')
vim.keymap.set('n', '<leader>!', ':-1read $HOME/.config/nvim/.skeleton.html<CR>5jwf>a')

-- lsp
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]implementation' })
vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { desc = '[G]oto Type Definition' })
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = '[G]oto [S]ignature Help' })
vim.keymap.set('n', 'rn', vim.lsp.buf.rename, { desc = '[R]ename [N]ame' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = '[C]ode [F]ormat' })

-- search and replace
vim.keymap.set('n', '<leader>sr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[S]earch and [R]eplace' })

-- quickfix
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Prev [Q]uickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next [Q]uickfix' })
vim.keymap.set('n', '<leader>q', function()
  custom.toggle_quickfix()
end, { desc = 'Toggle [Q]quickfix' })

-- diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Line [E]rrors' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [D]iagnotsitc' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev [D]iagnostic' })

-- disable highlights
vim.keymap.set('n', '<Esc>', function()
  custom.clear_highlight_and_close_float()
end, { noremap = true, silent = true })

-- disable macro recording
vim.keymap.set('n', 'q', '<Nop>')

-- center screen
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- indenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- visual select
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<S-Up>', ":m '<-2<CR>gv=gv")

-- disable register
vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])
vim.keymap.set({ 'n', 'v' }, 'C', [["_C]])

-- rezise windows
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- tmux
vim.keymap.set('n', '<C-f>', "<cmd>silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>", { silent = true, desc = 'tmux-sessionizer' })
vim.keymap.set('n', '<M-t>', function()
  custom.tmux_pane_toggle()
end, { desc = '[T]oggle tmux split' })
