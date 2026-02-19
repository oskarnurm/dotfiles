vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")

vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("i", "<C-space>", "<C-x><C-o>")

vim.keymap.set("n", "<leader>k", "<cmd>KodaFetch<CR>")

vim.keymap.set("n", "<leader>q", function()
  local is_qf = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(is_qf and "cclose" or "copen")
end, { desc = "Toggle quickfix" })
