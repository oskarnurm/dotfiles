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

vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")

vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>")
vim.keymap.set("n", "<leader>m", "<cmd>Pick help<CR>")
vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines<CR>")
vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", "<cmd>Pick git_hunks<CR>")
vim.keymap.set(
  "n",
  "<leader>n",
  function() require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } }) end,
  { desc = "Pick Neovim" }
)

local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
-- vim.keymap.set({ "x", "o" }, "af", function() ts_select("@function.outer", "textobjects") end)
-- vim.keymap.set({ "x", "o" }, "if", function() ts_select("@function.inner", "textobjects") end)
-- vim.keymap.set({ "x", "o" }, "ac", function() ts_select("@class.outer", "textobjects") end)
-- vim.keymap.set({ "x", "o" }, "ic", function() ts_select("@class.inner", "textobjects") end)
-- vim.keymap.set({ "x", "o" }, "al", function() ts_select("@loop.outer", "textobjects") end)
-- vim.keymap.set({ "x", "o" }, "il", function() ts_select("@loop.inner", "textobjects") end)
