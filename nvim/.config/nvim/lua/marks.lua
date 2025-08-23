--[[
  Marks / Bookmarks / Harpoon Replacement
  Uses m{1-9} to set marks in a file and then '{1-9} to jump to them

  Borrowed from: https://github.com/neovim/neovim/discussions/33335

  My modification only overrides m{1-9} to act as global marks with notifications
  All other mark functionality (a-z, A-Z, etc.) remains unchanged
--]]

-- Convert a mark number (1-9) to its corresponding character (A-I)
local function mark2char(mark)
  if mark:match("[1-9]") then
    return string.char(mark + 64)
  end
  return mark
end

-- Override m key to handle numeric marks specially
vim.keymap.set("n", "m", function()
  local mark = vim.fn.getcharstr()

  -- Only override numeric marks (1-9)
  if mark:match("[1-9]") then
    local char = mark2char(mark)
    vim.cmd("mark " .. char)
    vim.notify("Added mark " .. mark, vim.log.levels.INFO, { title = "Marks" })
  else
    -- For all other marks (a-z, A-Z, etc.), use default behavior
    vim.fn.feedkeys("m" .. mark, "n")
  end
end, { desc = "Add mark" })

-- Override ' key to handle numeric marks specially
vim.keymap.set("n", "'", function()
  local mark = vim.fn.getcharstr()

  -- Only override numeric marks (1-9)
  if mark:match("[1-9]") then
    local char = mark2char(mark)
    local mark_pos = vim.api.nvim_get_mark(char, {})
    if mark_pos[1] == 0 then
      return vim.notify("No mark at " .. mark, vim.log.levels.WARN, { title = "Marks" })
    end
    vim.fn.feedkeys("'" .. char, "n")
  else
    -- For all other marks (a-z, A-Z, etc.), use default behavior
    vim.fn.feedkeys("'" .. mark, "n")
  end
end, { desc = "Go to mark" })

-- Delete numeric marks with notification
vim.keymap.set("n", "<Leader>md", function()
  local mark = vim.fn.getcharstr()

  -- Only handle numeric marks specially
  if mark:match("[1-9]") then
    vim.api.nvim_del_mark(mark2char(mark))
    vim.notify("Deleted mark " .. mark, vim.log.levels.INFO, { title = "Marks" })
  else
    -- For other marks, just delete normally without notification
    vim.api.nvim_del_mark(mark)
  end
end, { desc = "Delete mark" })

-- Delete all numeric marks (A-I only)
vim.keymap.set("n", "<Leader>mD", function()
  vim.cmd("delmarks A-I")
  vim.notify("Deleted all numeric marks (1-9)", vim.log.levels.INFO, { title = "Marks" })
end, { desc = "Delete all numeric marks" })
