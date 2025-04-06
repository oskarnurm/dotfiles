-- stylua: ignore
local custom = require 'config.utils'

-- completion
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")
vim.keymap.set("n", "<leader>!", ":-1read $HOME/.config/nvim/.skeleton.html<CR>5jwf>a", { desc = "HTML Boilerplate" })

-- search and replace
vim.keymap.set(
  "n",
  "<leader>sr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search and Replace" }
)

-- quickfix
vim.keymap.set("n", "<leader>q", function()
  custom.toggle_quickfix()
end, { desc = "Toggle Qquickfix" })

-- diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Float" })

-- disable highlights
vim.keymap.set("n", "<Esc>", function()
  custom.clear_highlight_and_close_float()
end, { noremap = true, silent = true })

-- disable macro recording
vim.keymap.set("n", "q", "<Nop>")

-- center screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- visual select
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")

-- disable register
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("v", "<leader>p", [["_dP]])

-- rezise windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- tmux
vim.keymap.set(
  "n",
  "<C-f>",
  "<cmd>silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>",
  { silent = true, desc = "tmux-sessionizer" }
)
vim.keymap.set("n", "<M-t>", function()
  custom.tmux_pane_toggle()
end, { desc = "Toggle tmux split" })
