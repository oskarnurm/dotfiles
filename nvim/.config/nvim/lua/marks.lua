-- Marks wrapper
-- See: https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/util/marks.lua

vim.keymap.set("n", "m", function()
  local mark = vim.fn.getcharstr()

  if mark:match("[1-9]") then
    local char = string.char(tonumber(mark) + 64)
    vim.cmd("mark " .. char)
    vim.notify("Added mark " .. mark, vim.log.levels.INFO, { title = "Marks" })
  else
    vim.cmd("normal! m" .. mark)
  end
end, { desc = "Add mark" })

vim.keymap.set("n", "'", function()
  local mark = vim.fn.getcharstr()

  if mark:match("[1-9]") then
    local char = string.char(tonumber(mark) + 64)
    local mark_pos = vim.api.nvim_get_mark(char, {})
    if mark_pos[1] == 0 then
      return vim.notify("No mark at " .. mark, vim.log.levels.WARN, { title = "Marks" })
    end
    vim.cmd("normal! '" .. char)
  else
    vim.cmd("normal! '" .. mark)
  end
end, { desc = "Go to mark" })
