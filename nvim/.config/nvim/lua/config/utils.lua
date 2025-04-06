local M = {}

function M.clear_highlight_and_close_float()
  vim.cmd 'noh'
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- Function to toggle the quickfix window
function M.toggle_quickfix()
  local is_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      is_open = true
      break
    end
  end
  if is_open then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen'
  end
end

-- Toggle tmux pane below with correct path
M.tmux_pane_toggle = function(dir)
  -- NOTE: variable that controls the auto-cd behavior
  local auto_cd_to_new_dir = true
  -- NOTE: Variable to control pane direction: 'right' or 'bottom'
  -- If you modify this, make sure to also modify TMUX_PANE_DIRECTION in the
  -- zsh-vi-mode section on the .zshrc file
  -- Also modify this in your tmux.conf file if you want it to work when in tmux
  -- copy-mode
  local pane_direction = vim.g.tmux_pane_direction or 'bottom'
  -- NOTE: Below, the first number is the size of the pane if split horizontally,
  -- the 2nd number is the size of the pane if split vertically
  local pane_size = (pane_direction == 'right') and 60 or 15
  local move_key = (pane_direction == 'right') and 'C-l' or 'C-k'
  local split_cmd = (pane_direction == 'right') and '-h' or '-v'
  -- if no dir is passed, use the current file's directory
  local file_dir = dir or vim.fn.expand '%:p:h'
  -- Simplified this, was checking if a pane existed
  local has_panes = vim.fn.system('tmux list-panes | wc -l'):gsub('%s+', '') ~= '1'
  -- Check if the current pane is zoomed (maximized)
  local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub('%s+', '') == '1'
  -- Escape the directory path for shell
  local escaped_dir = file_dir:gsub("'", "'\\''")
  -- If any additional pane exists
  if has_panes then
    if is_zoomed then
      -- Compare the stored pane directory with the current file directory
      if auto_cd_to_new_dir and vim.g.tmux_pane_dir ~= escaped_dir then
        -- If different, cd into the new dir
        vim.fn.system('tmux send-keys -t :.+ \'cd "' .. escaped_dir .. '"\' Enter')
        -- Update the stored directory to the new one
        vim.g.tmux_pane_dir = escaped_dir
      end
      -- If zoomed, unzoom and switch to the correct pane
      vim.fn.system 'tmux resize-pane -Z'
      vim.fn.system('tmux send-keys ' .. move_key)
    else
      -- If not zoomed, zoom current pane
      vim.fn.system 'tmux resize-pane -Z'
    end
  else
    -- Store the initial directory in a Neovim variable
    if vim.g.tmux_pane_dir == nil then
      vim.g.tmux_pane_dir = escaped_dir
    end
    vim.fn.system('tmux split-window ' .. split_cmd .. ' -l ' .. pane_size .. ' \'cd "' .. escaped_dir .. '"&& zsh\'')
    vim.fn.system('tmux send-keys ' .. move_key)
  end
end

return M
