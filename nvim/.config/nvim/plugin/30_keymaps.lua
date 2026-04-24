vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")

vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("i", "<C-space>", "<C-x><C-o>")
vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.setqflist, { desc = "Open Errors" })

vim.keymap.set("n", "<leader>k", "<cmd>KodaFetch<CR>")

-- Quickfix toggle
vim.keymap.set("n", "<leader>q", function()
  local is_qf = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(is_qf and "cclose" or "copen")
end, { desc = "Quickfix Toggle" })

-- Loclist toggle
vim.keymap.set("n", "<leader>l", function()
  local is_loc = vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
  vim.cmd(is_loc and "lclose" or "lopen")
end, { desc = "Location List Toggle" })

-- Treesitter-incremental-selection
vim.keymap.set({ "n", "x", "o" }, "<A-n>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Treesitter Select Next Node" })

vim.keymap.set({ "n", "x", "o" }, "<A-p>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Treesitter Select Previous Node " })

-- Smart terminal toggle
local term_buf = nil
vim.keymap.set({ "n", "t" }, "<leader>tt", function()
  local term_win = nil
  -- Find any windows displaying our terminal buffer
  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    local wins = vim.fn.win_findbuf(term_buf)
    if #wins > 0 then term_win = wins[1] end
  end

  if term_win then
    vim.api.nvim_win_close(term_win, false)
  else
    -- If it's hidden or doesn't exist, open it
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.cmd("vsplit | b" .. term_buf)
    else
      vim.cmd("vsplit | term")
      term_buf = vim.api.nvim_get_current_buf()
    end
    vim.cmd("wincmd L")
    vim.cmd("startinsert!")
  end
end, { desc = "Toggle Terminal" })
