vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chiefdog"

-- stylua: ignore start

-- Palette Mapping
-- The Greyscale Foundation 
local black       = "#121212"
local darkgrey    = "#272727"
local mediumgray  = "#525252"
local gray        = "#7F7F7F"
local silver      = "#CCCCCC"
local offwhite    = "#DDDDDD"
local white       = "#F2F2F2"

-- The Color Accents
local lavender = "#CFCFEA"
local blue     = "#8EBEEC"
local green    = "#86CD82"
local yellow   = "#DFDF8E"
local orange   = "#E9B872"
local red      = "#FE5F55"
local orchid   = "#D4ADCF"


-- Terminal Colors
local ansi = {
  black  = "#121212",
  red    = "#ff7676",
  green  = "#a3d6a3",
  white  = "#ffffff",
  grey   = "#b3b3b3",
  pink   = "#f4b8e4",
  milk   = "#fafafa",
  blue   = "#a5adce",
}

local bright = {
  grey   = "#666666",
  red    = "#ff5733",
  green  = "#8ec772",
  yellow = "#d9ba73",
  white  = "#ffffff",
  pink   = "#f2a4db",
  cyan   = "#5abfb5",
  blue   = "#b5bfe2",
}

-- Standard colors
vim.g.terminal_color_0 = ansi.black
vim.g.terminal_color_1 = ansi.red
vim.g.terminal_color_2 = ansi.green
vim.g.terminal_color_3 = ansi.white
vim.g.terminal_color_4 = ansi.grey
vim.g.terminal_color_5 = ansi.pink
vim.g.terminal_color_6 = ansi.milk
vim.g.terminal_color_7 = ansi.blue

-- Bright colors
vim.g.terminal_color_8 = bright.grey
vim.g.terminal_color_9 = bright.red
vim.g.terminal_color_10 = bright.green
vim.g.terminal_color_11 = bright.yellow
vim.g.terminal_color_12 = bright.blue
vim.g.terminal_color_13 = bright.pink
vim.g.terminal_color_14 = bright.cyan
vim.g.terminal_color_15 = bright.white

local groups = {
  Normal       = { bg = black, fg = offwhite },
  NormalFloat  = { bg = "none" },
  FloatBorder  = { bg = "none", fg = offwhite },
  Cursor       = { bg = white, fg = darkgrey },
  CursorLine   = { bg = darkgrey },
  CursorColumn = { bg = darkgrey },
  ColorColumn  = { bg = darkgrey },
  LineNr       = { fg = gray },
  CursorLineNr = { fg = blue, bold = true },
  VertSplit    = { fg = mediumgray },
  StatusLine   = { bg = darkgrey, fg = offwhite },
  StatusLineNC = { bg = darkgrey, fg = "none" },
  WinBar       = { bg = black, fg = white, bold = true },
  WinBarNC     = { bg = black, fg = gray },
  Directory    = { fg = blue },
  Pmenu        = { bg = "none" },
  PmenuSel     = { bg = mediumgray },
  PmenuSbar    = { bg = mediumgray },
  PmenuThumb   = { bg = mediumgray },
  Visual       = { bg = mediumgray }, -- Visual selection
  Search       = { bg = mediumgray },
  IncSearch    = { link = "Search" },
  CurSearch    = { fg = orange, bg = darkgrey },
  MatchParen   = { bg = gray, fg = darkgrey },
  NonText      = { fg = mediumgray },
  EndOfBuffer  = { fg = gray },
  Comment      = { fg = gray, italic = true },
  Title        = { fg = lavender, bold = true },
  Todo         = { fg = darkgrey, bg = yellow, bold = true },
  Conceal      = { fg = gray },
  Underlined   = { underline = true },
  Special      = { fg = blue },

  -- "Confirmation" text (Save? Yes/No)
  Question   = { fg = yellow, bold = true },
  MoreMsg    = { fg = yellow, bold = true },
  ErrorMsg   = { fg = red, bold = true },
  WarningMsg = { fg = yellow, bold = true },
  ModeMsg    = { fg = yellow, bold = true },

  QuickFixLine = { bg = "none", fg = yellow },
  qfLineNr     = { fg = gray },

  -- Keywords & Operators
  Keyword  = { fg = offwhite },
  Operator = { fg = white, bold = true },
  ["@keyword.return"] = { fg = yellow },

  Function      = { fg = orchid },
  ["@function"] = { fg = white, bold = true },
  ["@function.call"] = { fg = orchid },
  ["@function.builtin"] = { fg = blue },
  ["@lsp.type.method"]  = { fg = silver },
  -- Might be only Lua specific
  -- ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },

  ["@variable"] = { fg = silver },
  ["@variable.member"] = { fg = white }, -- Properties (inter.className)
  ["@property"] = { fg = white },

  -- Types
  ["@type"] = { fg = lavender },
  ["@type.builtin"] = { fg = lavender },
  ["@constructor"]  = { fg = lavender },

  -- Constant
  ["@string"] = { fg = green, italic = true },
  ["@number"] = { fg = yellow },
  ["@boolean"]  = { fg = yellow },
  ["@constant"] = { fg = lavender },

  -- HTML/JSX Tags
  ["@tag"] = { fg = lavender },
  ["@tag.builtin"] = { fg = lavender },
  ["@tag.attribute"] = { fg = silver }, --'className=', 'lang=', 'key='
  ["@tag.delimiter"] = { fg = gray },

  -- Punctuation
  ["@punctuation.delimiter"] = { fg = white },
  ["@punctuation.bracket"]   = { fg = gray },
  ["@punctuation.member"]    = { fg = gray },
  ["@punctuation.special"]   = { fg = blue },
  ["@punctuation.section.embedded"] = { fg = gray },

  -- DIAGNOSTICS & GIT
  DiagnosticError = { fg = red },
  DiagnosticWarn  = { fg = orange },
  DiagnosticHint  =  { fg = blue },
  DiagnosticInfo  = { fg = green },

  DiagnosticVirtualTextError = { bg = "none", fg = red },
  DiagnosticVirtualTextWarn  = { bg = "none", fg = orange },
  DiagnosticVirtualTextHint  = { bg = "none", fg = blue },
  DiagnosticVirtualTextInfo  = { bg = "none", fg = green },

  --- Gitsigns
  GitSignsAdd = { fg = green },
  GitSignsChange = { fg = yellow },
  GitSignsDelete = { fg = red },

  DiffAdd = { bg = darkgrey, fg = green },
  DiffChange = { bg = darkgrey, fg = yellow },
  DiffDelete = { bg = darkgrey, fg = red },
  DiffText = { bg = mediumgray, fg = yellow },

  -- Cmp / Blink
  BlinkCmpLabelMatch = { fg = orange },

  -- Checkhealth
  healthSuccess = { fg = green, bg = black },

  --- Fugitive
  diffAdded = { link = "DiffAdd" },
  diffRemoved = { link = "DiffDelete" },

  -- 
  SnacksPickerDir = { fg = "#b0b0b0" },


  --- Statusline
  StatuslineAdd = { fg = green, bg = darkgrey },
  StatuslineErr = { fg = red, bg = darkgrey },
  StatuslineHint = { fg = blue, bg = darkgrey },
  StatuslineInfo = { fg = green, bg = darkgrey },
  StatuslineWarn = { fg = yellow, bg = darkgrey },
  StatuslineBlue = { fg = ansi.blue, bg = darkgrey },
  StatuslineRed = { fg = ansi.red, bg = darkgrey },
  StatuslineGreen = { fg = ansi.green, bg = darkgrey },
  StatuslineCyan = { fg = bright.cyan, bg = darkgrey },
  StatuslineMagenta = { fg = ansi.pink, bg = darkgrey },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
