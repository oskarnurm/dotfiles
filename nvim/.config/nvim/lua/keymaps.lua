-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>ft", vim.cmd.Ex, { desc = "Filte tree" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Error messages" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix List" }) --> Handeled by Trouble
-- vim.keymap.set("n", "<leader>l", "<cmd>lopen<cr>", { desc = "Location List" })

-- Move between Quickfix-list
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Prev Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>zz", { desc = "Prev Location List" })
vim.keymap.set("n", "]l", "<cmd>lnext<CR>zz", { desc = "Next Location List" })

-- Center screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Better indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move a block of text up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Deleting to the void
vim.keymap.set({ "n", "v" }, "x", '"_x')

-- Do without yanking
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste whitout yanking" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete whitout yanking" })

-- Launch tmux-sessionizer on CTRL+f
vim.keymap.set("n", "<C-f>", ":silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>", { silent = true })

-- Search and replace helper
vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and Replace" })

-- Open lazygit with floaterm
vim.keymap.set("n", "<leader>lg", ":FloatermNew --width=0.9 --height=0.9 lazygit<=R>", { silent = true, desc = "Lazy Git" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
