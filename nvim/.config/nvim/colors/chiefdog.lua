vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

-- stylua: ignore start
vim.g.colors_name = "chiefdog"

-- Palette Mapping
local colors = {
  black     = "#121212",
  darkgray  = "#272727", -- UI Backgrounds
  gray      = "#b3b3b3",
  lightgray = "#fafafa",
  white     = "#ffffff",
  red       = "#ff7676",
  green     = "#a3d6a3",
  pink      = "#f4b8e4",
  blue      = "#a5adce",
}
local darker = {
  gray   = "#666666",
  red    = "#ff5733",
  green  = "#8ec772",
  yellow = "#d9ba73",
  white  = "#ffffff",
  pink   = "#f2a4db",
  cyan   = "#5abfb5",
  blue   = "#b5bfe2",
}

-- Terminal Colors
vim.g.terminal_color_0 = colors.black
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.white
vim.g.terminal_color_4 = colors.gray
vim.g.terminal_color_5 = colors.pink
vim.g.terminal_color_6 = colors.lightgray
vim.g.terminal_color_7 = colors.blue
vim.g.terminal_color_8  = darker.gray
vim.g.terminal_color_9  = darker.red
vim.g.terminal_color_10 = darker.green
vim.g.terminal_color_11 = darker.yellow
vim.g.terminal_color_12 = darker.blue
vim.g.terminal_color_13 = darker.pink
vim.g.terminal_color_14 = darker.cyan
vim.g.terminal_color_15 = darker.white

local groups = {
  -- General
  Normal        = { bg = colors.black, fg = colors.gray },
  NormalFloat   = { bg = "none" },
  FloatBorder   = { bg = "none", fg = colors.gray },
  Cursor        = { bg = colors.lightgray, fg = colors.darkgray },
  CursorLine    = { bg = colors.darkgray },
  CursorColumn  = { bg = colors.darkgray },
  ColorColumn   = { bg = colors.darkgray },
  LineNr        = { fg = darker.gray },
  CursorLineNr  = { fg = darker.blue, bold = true },
  VertSplit     = { fg = darker.gray },
  StatusLine    = { bg = "none", fg = colors.white },
  StatusLineNC  = { bg = colors.darkgray, fg = "none" },
  WinBar        = { bg = colors.black, fg = colors.lightgray, bold = true },
  WinBarNC      = { bg = colors.black, fg = colors.gray },
  Directory     = { fg = darker.blue },
  Pmenu         = { bg = "none" },
  PmenuSel      = { bg = darker.gray },
  Visual        = { bg = darker.gray },
  Search        = { bg = darker.gray },
  IncSearch     = { link = "Search" },
  CurSearch     = { fg = darker.yellow, bg = colors.darkgray },
  MatchParen    = { bg = colors.gray, fg = colors.darkgray },
  NonText       = { fg = darker.gray },
  EndOfBuffer   = { fg = darker.gray },
  Comment       = { fg = darker.gray, italic = true },
  Title         = { fg = colors.blue, bold = true },
  Todo          = { fg = colors.darkgray, bg = darker.yellow, bold = true },
  Underlined    = { underline = true },
  Special       = { fg = colors.blue },


    -- Statusline text
  Question   = { fg = darker.yellow, bold = true },
  MoreMsg    = { fg = darker.yellow, bold = true },
  ErrorMsg   = { fg = darker.red, bold = true },
  WarningMsg = { fg = darker.yellow, bold = true },
  ModeMsg    = { fg = darker.yellow, bold = true },

  QuickFixLine = { bg = "none", fg = darker.yellow },
  qfLineNr     = { fg = colors.gray },

  -- Syntax
  Keyword = { fg = colors.white, bold = true },
  Operator = { fg = colors.lightgray, bold = true },
  ["@keyword.return"] = { fg = darker.yellow },

  Function = { fg = darker.pink },
  ["@function"] = { fg = colors.lightgray, bold = true },
  ["@function.call"] = { fg = darker.pink },
  ["@function.builtin"] = { fg = darker.blue },
  ["@lsp.type.method"] = { fg = colors.gray },

  ["@variable"] = { fg = colors.gray },
  ["@variable.member"] = { fg = colors.lightgray },
  ["@property"] = { fg = colors.lightgray },

  ["@type"] = { fg = colors.blue },
  ["@type.builtin"] = { fg = colors.blue },
  ["@constructor"] = { fg = colors.blue },

  ["@string"] = { fg = colors.green, italic = true },
  ["@number"] = { fg = darker.yellow },
  ["@boolean"] = { fg = darker.yellow },
  ["@constant"] = { fg = colors.blue },

  ["@tag"] = { fg = colors.blue },
  ["@tag.builtin"] = { fg = colors.blue },
  ["@tag.attribute"] = { fg = colors.gray },
  ["@tag.delimiter"] = { fg = darker.gray },

  ["@punctuation.delimiter"] = { fg = colors.lightgray },
  ["@punctuation.bracket"] = { fg = colors.gray },
  ["@punctuation.special"] = { fg = darker.blue },

  -- Diagnostics
  DiagnosticError = { fg = colors.red },
  DiagnosticWarn = { fg = darker.yellow },
  DiagnosticHint = { fg = darker.blue },
  DiagnosticInfo = { fg = darker.green },

  -- Git
  GitSignsAdd = { fg = darker.green },
  GitSignsChange = { fg = darker.yellow },
  GitSignsDelete = { fg = colors.red },

  DiffAdd = { bg = colors.darkgray, fg = darker.green },
  DiffChange = { bg = colors.darkgray, fg = darker.yellow },
  DiffDelete = { bg = colors.darkgray, fg = colors.red },

  -- Plugins
  BlinkCmpLabelMatch = { fg = darker.yellow },

  --- Fugitive
  diffAdded = { link = "DiffAdd" },
  diffRemoved = { link = "DiffDelete" },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
