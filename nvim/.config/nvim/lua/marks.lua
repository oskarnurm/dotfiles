--[[
  Marks / Bookmarks / Harpoon Replacement 
  Uses m{1-9} to set marks in a file and then '{1-9} to jump to them

  Borrowed from:
  https://github.com/neovim/neovim/discussions/33335
  https://github.com/LJFRIESE/nvim/blob/master/lua/config/autocmds.lua#L196-L340
  https://github.com/olimorris/dotfiles/blob/main/.config/nvim/lua/util/marks.lua

  Modified to be used with mini.pick
--]]

-- Convert a mark number (1-9) to its corresponding character (A-I)
local function mark2char(mark)
  if mark:match("[1-9]") then
    return string.char(mark + 64)
  end
  return mark
end

-- List bookmarks in the session
local pick = require("mini.pick")
vim.api.nvim_create_user_command("PickMarks", function()
  local items = {}
  for _, m in ipairs(vim.fn.getmarklist()) do
    local lbl = (m.mark or ""):sub(2, 2)
    if lbl and lbl:match("^[A-I]$") and m.pos and m.pos[2] > 0 then
      local n = string.byte(lbl) - string.byte("A") + 1
      local path = m.file or ""
      local l, c = m.pos[2], (m.pos[3] or 0) + 1
      table.insert(items, { text = ("[%d] %s:%d:%d"):format(n, path, l, c), path = path, lnum = l, col = c })
    end
  end
  pick.start({
    source = {
      name = "Marks",
      items = items,
      preview = function(buf, it)
        pick.default_preview(buf, it)
      end,
      choose = function(it)
        if it.path ~= "" then
          vim.cmd.edit(vim.fn.fnameescape(it.path))
        end
        vim.api.nvim_win_set_cursor(0, { it.lnum, it.col - 1 })
      end,
    },
  })
end, {})

vim.keymap.set("n", "m", function()
  local mark = vim.fn.getcharstr()
  local char = mark2char(mark)
  vim.cmd("mark " .. char)
  if mark:match("[1-9]") then
    vim.notify("Added mark " .. mark, vim.log.levels.INFO, { title = "Marks" })
  else
    vim.fn.feedkeys("m" .. mark, "n")
  end
end, { desc = "Add mark" })

vim.keymap.set("n", "'", function()
  local mark = vim.fn.getcharstr()
  local char = mark2char(mark)
  local mark_pos = vim.api.nvim_get_mark(char, {})
  if mark_pos[1] == 0 then
    return vim.notify("No mark at " .. mark, vim.log.levels.WARN, { title = "Marks" })
  end

  vim.fn.feedkeys("'" .. mark2char(mark), "n")
end, { desc = "Go to mark" })

vim.keymap.set("n", "<Leader>mm", "<cmd>PickMarks<CR>", { desc = "List marks" })

vim.keymap.set("n", "<Leader>md", function()
  local mark = vim.fn.getcharstr()
  vim.api.nvim_del_mark(mark2char(mark))
  vim.notify("Deleted mark " .. mark, vim.log.levels.INFO, { title = "Marks" })
end, { desc = "Delete mark" })

vim.keymap.set("n", "<Leader>mD", function()
  vim.cmd("delmarks A-I")
  vim.notify("Deleted all marks", vim.log.levels.INFO, { title = "Marks" })
end, { desc = "Delete all marks" })
