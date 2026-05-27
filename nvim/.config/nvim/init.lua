require("vim._core.ui2").enable({})
_G.Config = {}

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- Utils
local misc = require("mini.misc")
Config.now = function(f) misc.safely("now", f) end
Config.later = function(f) misc.safely("later", f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely("event:" .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely("filetype:" .. ft, f) end

local gr = vim.api.nvim_create_augroup("custom-config", { clear = true })
Config.autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback(ev.data)
  end
  Config.autocmd("PackChanged", "*", f, desc)
end

-- LPS
Config.later(
  function()
    vim.lsp.enable({
      "basedpyright",
      "bashls",
      "clangd",
      "cssls",
      "gopls",
      "html",
      "jdtls",
      "jsonls",
      "lua_ls",
      "rust_analyzer",
      "tailwindcss",
      "tsgo",
      "ts_ls",
      "prismals",
      "emmet_language_server",
    })
  end
)

vim.api.nvim_create_autocmd({ "TermRequest" }, {
  desc = "Handles OSC 7 dir change requests",
  callback = function(ev)
    local val, n = string.gsub(ev.data.sequence, "\027]7;file://[^/]*", "")
    if n > 0 then
      -- OSC 7: dir-change
      local dir = val
      if vim.fn.isdirectory(dir) == 0 then
        vim.notify("invalid dir: " .. dir)
        return
      end
      vim.b[ev.buf].osc7_dir = dir
      if vim.api.nvim_get_current_buf() == ev.buf then vim.cmd.lcd(dir) end
    end
  end,
})
