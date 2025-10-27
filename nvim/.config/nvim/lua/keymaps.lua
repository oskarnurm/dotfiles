vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "[[", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "]]", "<cmd>cnext<CR>zz")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitue word" })
vim.keymap.set("n", "<leader>S", "<Cmd>vert sf #<CR>", { desc = "Split alternative file vertically" })
vim.keymap.set("n", "<M-w>", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<M-q>", "<cmd>update | quit<CR>")
vim.keymap.set("n", "<M-t>", "<cmd>tabnew<CR>")
for i = 1, 8 do
  vim.keymap.set({ "n", "t" }, "<M-" .. i .. ">", "<Cmd>tabnext " .. i .. "<CR>")
end
vim.keymap.set("n", "<leader>q", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Toggle quickfix" })
