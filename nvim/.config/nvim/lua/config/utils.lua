local M = {}

-- Clear highlight and close float
function M.clear_highlight_and_close_float()
  vim.cmd "noh"
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- Toggle the quickfix window
function M.toggle_quickfix()
  local is_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      is_open = true
      break
    end
  end
  if is_open then
    vim.cmd "cclose"
  else
    vim.cmd "copen"
  end
end

-- Toggle tmux pane below with correct path
M.tmux_pane_toggle = function()
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
end

return M
