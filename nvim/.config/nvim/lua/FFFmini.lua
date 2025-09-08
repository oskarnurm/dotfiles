local M = {
  state = {},
  ns_id = vim.api.nvim_create_namespace("MiniPick FFFiles Picker"),
}

local function find(query)
  local file_picker = require("fff.file_picker")

  query = query or ""
  local fff_result = file_picker.search_files(query, 100, 4, M.state.current_file_cache, false)

  local items = {}
  for _, fff_item in ipairs(fff_result) do
    local item = {
      text = fff_item.relative_path,
      path = fff_item.path,
    }
    table.insert(items, item)
  end

  return items
end

local function run()
  -- Setup fff.nvim
  local file_picker = require("fff.file_picker")
  if not file_picker.is_initialized() then
    local setup_success = file_picker.setup()
    if not setup_success then
      vim.notify("Could not setup fff.nvim", vim.log.levels.ERROR)
      return
    end
  end

  -- Cache current file to deprioritize in fff.nvim
  if not M.state.current_file_cache then
    local current_buf = vim.api.nvim_get_current_buf()
    if current_buf and vim.api.nvim_buf_is_valid(current_buf) then
      local current_file = vim.api.nvim_buf_get_name(current_buf)
      if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
        local relative_path = vim.fs.relpath(vim.uv.cwd(), current_file)
        M.state.current_file_cache = relative_path
      else
        M.state.current_file_cache = nil
      end
    end
  end

  -- Start picker
  MiniPick.start({
    source = {
      name = "FFFiles",
      items = find,
      match = function(_, _, query)
        local items = find(table.concat(query))
        MiniPick.set_picker_items(items, { do_match = false })
      end,
      show = function(buf, items, query)
        MiniPick.default_show(buf, items, query, { show_icons = true })
      end,
    },
  })

  M.state.current_file_cache = nil -- Reset cache
end

function M.setup()
  MiniPick.registry.fffiles = run
end

function M.is_initialized()
  return MiniPick.registry.fffiles ~= nil
end

return M
