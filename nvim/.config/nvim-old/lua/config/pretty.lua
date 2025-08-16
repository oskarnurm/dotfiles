-- plugin/pretty-qf.lua
-- Pretty Quickfix & Loclist — Trouble-like formatting without the Trouble UI

-- ──────────────────────────────────────────────────────────────────────────────
-- options (override by setting vim.g.pretty_qf = { ... } before this file runs)
local OPTS = vim.tbl_deep_extend("force", {
  enable_icons = true, -- try devicons, fallback to a generic icon
  enable_cursorline = true, -- highlight the current line in qf window
  signcolumn = "no", -- qf window signcolumn
  filename_only = true, -- show only basename (like Trouble)
  icon_default = "", -- used if devicons not available
  severity_icons = { -- mirrors Trouble-ish icons
    E = "", -- Error
    W = "", -- Warn
    I = "", -- Info
    N = "", -- Note/Hint
  },
  winopts = { -- extra window opts to apply to qf buffers
    wrap = false,
    number = false,
    relativenumber = false,
  },
}, vim.g.pretty_qf or {})

-- ──────────────────────────────────────────────────────────────────────────────
-- optional devicons
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

-- global textfunc (required shape for 'quickfixtextfunc')
---@param info {quickfix:1|0, id:integer, winid:integer, start_idx:integer, end_idx:integer}
---@return string[]
function _G.PrettyQf_textfunc(info)
  local list
  if info.quickfix == 1 then
    list = vim.fn.getqflist({ id = info.id, items = 1 }).items
  else
    list = vim.fn.getloclist(info.winid, { id = info.id, items = 1 }).items
  end

  local out = {}
  local s, e = info.start_idx, info.end_idx

  for i = s, e do
    local it = list[i] or {}

    -- filename
    local fname = ""
    if it.bufnr and it.bufnr > 0 then
      fname = vim.fn.bufname(it.bufnr)
    elseif it.filename then
      fname = it.filename
    end

    local shown = fname ~= ""
        and (OPTS.filename_only and vim.fn.fnamemodify(fname, ":t") or vim.fn.fnamemodify(fname, ":."))
      or "[No Name]"

    -- file icon
    local icon = OPTS.icon_default
    if OPTS.enable_icons and devicons_ok then
      local ext = shown:match("^.+%.(.+)$")
      icon = devicons.get_icon(shown, ext, { default = true }) or OPTS.icon_default
    end

    -- position
    local lnum = tonumber(it.lnum) or 0
    local col = tonumber(it.col) or 0

    -- severity-ish icon from 'type' (E/W/I/N…)
    local sev = type(it.type) == "string" and it.type:sub(1, 1) or "I"
    local sicon = OPTS.severity_icons[sev] or OPTS.severity_icons.I

    -- message
    local text = (it.text or ""):gsub("%s+", " "):gsub("^%s+", "")

    -- final line (spaces matter for a clean look)
    table.insert(out, string.format(" %s  %s  %s:%d:%d  %s", sicon, icon, shown, lnum, col, text))
  end

  return out
end

-- set the formatter (works for both quickfix & loclist)
vim.o.quickfixtextfunc = "v:lua.PrettyQf_textfunc"

-- qf window cosmetics
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(ev)
    local bo, wo = vim.bo[ev.buf], vim.wo[vim.api.nvim_get_current_win()]
    bo.buflisted = false
    wo.signcolumn = OPTS.signcolumn
    wo.cursorline = OPTS.enable_cursorline
    for k, v in pairs(OPTS.winopts or {}) do
      wo[k] = v
    end
  end,
})

-- user commands to toggle/refresh
vim.api.nvim_create_user_command("PrettyQfEnable", function()
  vim.o.quickfixtextfunc = "v:lua.PrettyQf_textfunc"
  print("[pretty-qf] enabled")
end, {})

vim.api.nvim_create_user_command("PrettyQfDisable", function()
  vim.o.quickfixtextfunc = ""
  print("[pretty-qf] disabled")
end, {})

vim.api.nvim_create_user_command("PrettyQfRefresh", function()
  -- reopen list to refresh rendered lines without changing entries
  if vim.fn.getqflist({ items = 0 }).items ~= nil then
    vim.cmd.cwindow()
  end
  if vim.fn.getloclist(0, { items = 0 }).items ~= nil then
    vim.cmd.lwindow()
  end
end, {})

-- optional: default mappings (comment out if unwanted)
-- vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>", { desc = "Quickfix Open" })
-- vim.keymap.set("n", "<leader>l", "<cmd>lopen<cr>", { desc = "Loclist Open" })
