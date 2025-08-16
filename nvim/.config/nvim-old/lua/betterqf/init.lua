local M = {}

-- Format quickfix lines: "path │ line │ message" (no columns), project-relative paths
function M.qftf(info)
  local items = vim.fn.getqflist({ id = info.id, items = 0 }).items
  local ret = {}

  for i = info.start_idx, info.end_idx do
    local it = items[i]
    -- Derive a descriptive, project-relative file path
    local name = ""
    if it.bufnr and it.bufnr > 0 then
      name = vim.api.nvim_buf_get_name(it.bufnr)
    end
    if (not name or name == "") and it.filename then
      name = it.filename
    end
    if not name or name == "" then
      name = "[No Name]"
    end

    -- Make relative to cwd or ~, then mildly shorten long segments
    name = vim.fn.fnamemodify(name, ":~:.")
    name = vim.fn.pathshorten(name) -- keeps it descriptive but not crazy long

    local lnum = it.lnum or 0
    local text = (it.text or ""):gsub("^%s+", "")

    -- Only show line numbers (no column), and keep things tidy
    ret[#ret + 1] = string.format("%s │ %d │ %s", name, lnum, text)
  end

  return ret
end

-- Is any quickfix window open?
local function qf_is_open()
  -- Look through *current tabpage* windows and find the quickfix one
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 then
      return true, info.winid
    end
  end
  return false, nil
end

-- Focus the quickfix window if it's open
local function qf_focus()
  local open, win = qf_is_open()
  if open and win then
    pcall(vim.api.nvim_set_current_win, win)
  end
end

-- Toggle the quickfix list; when opening, auto-focus it.
function M.toggle()
  local open = qf_is_open() -- returns true/false as first value
  if open then
    vim.cmd.cclose()
  else
    vim.cmd("copen 10")
    vim.schedule(qf_focus)
  end
end

-- Wrap-aware next/prev
function M._wrap_move(dir)
  -- dir = 1 for next, -1 for prev
  local qf = vim.fn.getqflist({ idx = 0, size = 0 })
  local idx, size = qf.idx or 0, qf.size or 0
  if size == 0 then
    return
  end

  if dir == 1 then
    if idx >= size then
      vim.cmd.cfirst()
    else
      vim.cmd.cnext()
    end
  else
    if idx <= 1 then
      vim.cmd.clast()
    else
      vim.cmd.cprevious()
    end
  end
end

function M.next()
  M._wrap_move(1)
end
function M.prev()
  M._wrap_move(-1)
end

-- Setup: installs formatter, mappings, and a :QFToggle command.
function M.setup(opts)
  opts = opts or {}

  -- Use our custom formatter in the default quickfix window
  vim.o.quickfixtextfunc = "v:lua.require'betterqf'.qftf"

  -- Command to toggle quickfix
  vim.api.nvim_create_user_command("QFToggle", function()
    M.toggle()
  end, {})

  -- Optional global mapping to toggle (feel free to change)
  local toggle_key = opts.toggle_key or "<leader>q"
  if toggle_key ~= false then
    vim.keymap.set("n", toggle_key, M.toggle, { desc = "Toggle quickfix (betterqf)" })
  end

  -- Autocmd for quickfix buffers: focus on open + local maps for [[ and ]]
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(ev)
      -- Less visual clutter in the qf window
      vim.opt_local.wrap = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.cursorline = true
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false

      -- Buffer-local wrap-aware navigation
      vim.keymap.set("n", "]]", M.next, { buffer = ev.buf, desc = "Next quickfix (wrap)" })
      vim.keymap.set("n", "[[", M.prev, { buffer = ev.buf, desc = "Prev quickfix (wrap)" })

      -- When the window appears (via copen), jump focus here
      -- (If you used :QFToggle or copen directly)
      vim.schedule(function()
        local open, win = qf_is_open()
        if open then
          pcall(vim.api.nvim_set_current_win, win)
        end
      end)
    end,
  })
end

return M
