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
vim.keymap.set("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitue Word" })
vim.keymap.set("n", "<leader>S", "<cmd>vert sf #<CR>", { desc = "Split Alternative File" })
vim.keymap.set("n", "<Space>b", ":ls<CR>:b ", { desc = "Show Buffers" })
-- vim.keymap.set("n", "<leader>g", ":copen | :silent :grep! ", { desc = "Grep" })
vim.keymap.set("n", "<leader>f", ":find ", { desc = "Find Files" })
vim.keymap.set("n", "<leader>sc", ":colorscheme ", { desc = "Colorscheme" })
-- File navigation relative to current file
vim.keymap.set("n", "<Space>ee", ":e %:p:h/", { desc = "Edit relative" })
vim.keymap.set("i", "<C-o>", "<C-x><C-o>")

vim.keymap.set("n", "<leader>g", function()
  local term = vim.fn.input("Grep: ")
  if term == "" then
    return -- Don't run if cancelled
  end
  vim.cmd("copen")
  vim.cmd("silent grep! " .. term)
end, { desc = "Grep" })

-- toggle diagnostics
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Diagnostics" })

-- toggle quickfix list
vim.keymap.set("n", "<leader>q", function()
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
end, { desc = "Quickfix List" })

-- toggle location list
vim.keymap.set("n", "<leader>l", function()
  if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
    vim.cmd.lclose()
  else
    pcall(vim.cmd.lopen) -- lopen can fail if the location list is empty, so 'pcall' or a check is useful here.
  end
end, { desc = "Location List" })
