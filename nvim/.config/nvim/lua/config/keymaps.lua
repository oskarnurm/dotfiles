-- stylua: ignore start 

-- Completion
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")

-- Search and replace
vim.keymap.set("n", "cr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search & Replace" })
vim.keymap.set("n", "crc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = "Search, Replace & Confirm" })

-- Quickfix
vim.keymap.set("n", "<leader>q", function()
  local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Quickfix List" })

-- I find "]q" and "[q" awkward
vim.keymap.set("n", "[[", "<cmd>cprev<CR>")
vim.keymap.set("n", "]]", "<cmd>cnext<CR>")

-- Location list
vim.keymap.set("n", "<leader>l", function()
  local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
  if not success and err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end, { desc = "Location List" })

-- Clear highlight and close float
vim.keymap.set("n", "<Esc>", function()
  vim.cmd "noh"
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { noremap = true, silent = true })

-- Center screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Visual select
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")

-- Disable register
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("v", "<leader>p", [["_dP]])

-- Rezise windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- Tmux
-- stylua: ignore stop
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww '~/dotfiles/scripts/tmux-sessionizer.sh'<CR>")
vim.keymap.set("n", "<M-t>", function()
local pane_size = 15
  local move_key = "C-k"
  local split_cmd = "-v"
  local file_dir = vim.fn.expand "%:p:h"
  local has_panes = vim.fn.system("tmux list-panes | wc -l"):gsub("%s+", "") ~= "1"
  local is_maximized = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"

  if has_panes then
    if is_maximized then
      if vim.g.tmux_pane_dir ~= file_dir then
        vim.fn.system("tmux send-keys -t :.+ 'cd \"" .. file_dir .. "\"' Enter")
        vim.g.tmux_pane_dir = file_dir
      end
      vim.fn.system "tmux resize-pane -Z"
      vim.fn.system("tmux send-keys " .. move_key)
    else
      vim.fn.system "tmux resize-pane -Z"
    end
  else
    if vim.g.tmux_pane_dir == nil then
      vim.g.tmux_pane_dir = file_dir
    end
    vim.fn.system(
      "tmux split-window " .. split_cmd .. " -l " .. pane_size .. " 'cd \"" .. file_dir .. "\" && DISABLE_PULL=1 zsh'"
    )
    vim.fn.system "tmux send-keys "
  end
end)
