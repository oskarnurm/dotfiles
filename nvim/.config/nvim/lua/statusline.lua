local M = {}

M.diagnostics = {
  ERROR = "",
  WARN = "",
  HINT = "",
  INFO = "",
}

function _G._statusline_component(name)
  return M[name]()
end

function M.diagnostic_status()
  local ignore = {
    ["c"] = true, -- command mode
    ["t"] = true, -- terminal mode
  }

  local mode = vim.api.nvim_get_mode().mode

  if ignore[mode] then
    return ""
  end

  local levels = vim.diagnostic.severity
  local errors = #vim.diagnostic.get(0, { severity = levels.ERROR })
  local warnings = #vim.diagnostic.get(0, { severity = levels.WARN })
  local hints = #vim.diagnostic.get(0, { severity = levels.HINT })
  local info = #vim.diagnostic.get(0, { severity = levels.INFO })

  local status_parts = {}

  if errors > 0 then
    table.insert(status_parts, string.format("%s %d", M.diagnostics.ERROR, errors))
  end

  if warnings > 0 then
    table.insert(status_parts, string.format("%s %d", M.diagnostics.WARN, warnings))
  end

  if hints > 0 then
    table.insert(status_parts, string.format("%s %d", M.diagnostics.HINT, hints))
  end

  if info > 0 then
    table.insert(status_parts, string.format("%s %d", M.diagnostics.INFO, info))
  end

  if #status_parts > 0 then
    return " " .. table.concat(status_parts, " ")
  end
  return ""
end

local statusline = {
  "%t",
  "%r",
  "%m",
  "%=",
  '%{%v:lua._statusline_component("diagnostic_status")%} ',
  " %{&filetype} ",
  " %3l:%-2c ",
}

vim.o.statusline = table.concat(statusline, "")
