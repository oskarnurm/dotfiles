-- Highlight when yanking text
Config.autocmd("TextYankPost", nil, function() vim.hl.on_yank() end, "Highlight on yank")

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
Config.autocmd(
  "FileType",
  nil,
  function() vim.cmd("setlocal formatoptions-=c formatoptions-=o") end,
  "Better formatoptions"
)

-- Start wildcard expansion in the command-line, using the behavior
-- defined by the 'wildmode' and 'wildoptions' settings.
Config.autocmd("CmdlineChanged", { ":", "/", "?" }, function() vim.fn.wildtrigger() end)

-- Go to last location when opening a buffer
Config.autocmd("BufReadPost", nil, function(ev)
  local exclude = { "gitcommit" }
  local buf = ev.buf
  if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then return end
  vim.b[buf].lazyvim_last_loc = true
  local mark = vim.api.nvim_buf_get_mark(buf, '"')
  local lcount = vim.api.nvim_buf_line_count(buf)
  if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
end, "Go to last loc in buffer")

-- Auto-select first match in cmdline for :find, :b and :e
Config.autocmd("CmdlineLeavePre", ":", function()
  local info = vim.fn.cmdcomplete_info()
  if info.matches and #info.matches > 0 and info.selected == -1 then
    local cmd = vim.fn.getcmdline()
    if cmd:match("^find") or cmd:match("^b") or cmd:match("^e") then
      vim.fn.setcmdline(cmd:match("^(%w+)%s") .. " " .. info.matches[1])
    end
  end
end, "Auto select first match in cmdline")

-- Wrap and check for spell in text filetypes
local filetypes = { "text", "plaintex", "typst", "gitcommit", "markdown" }
Config.autocmd("FileType", filetypes, function()
  vim.opt_local.wrap = true
  vim.opt_local.spell = true
end, "Wrap and check for spell in text filetypes")
