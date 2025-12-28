vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chiefdog"

-- stylua: ignore start

-- Palette Mapping
-- The Greyscale Foundation 
local black       = "#121212"
local dark_bray   = "#272727"
local medium_gray = "#525252"
local gray        = "#7F7F7F"
local silver      = "#CCCCCC"
local off_white   = "#DDDDDD"
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
  Normal       = { bg = black, fg = off_white },
  NormalFloat  = { bg = "none" },
  FloatBorder  = { bg = "none", fg = off_white },
  Cursor       = { bg = white, fg = dark_gray },
  CursorLine   = { bg = dark_gray },
  CursorColumn = { bg = dark_gray },
  ColorColumn  = { bg = dark_gray },
  LineNr       = { fg = gray },
  CursorLineNr = { fg = blue, bold = true },
  VertSplit    = { fg = medium_gray },
  StatusLine   = { bg = dark_gray, fg = off_white },
  StatusLineNC = { bg = dark_gray, fg = "none" },
  WinBar       = { bg = black, fg = white, bold = true },
  WinBarNC     = { bg = black, fg = gray },
  Directory    = { fg = blue },
  Pmenu        = { bg = "none" },
  PmenuSel     = { bg = medium_gray },
  PmenuSbar    = { bg = medium_gray },
  PmenuThumb   = { bg = medium_gray },
  Visual       = { bg = medium_gray }, -- Visual selection
  Search       = { bg = medium_gray },
  IncSearch    = { link = "Search" },
  CurSearch    = { fg = orange, bg = dark_gray },
  MatchParen   = { bg = gray, fg = dark_gray },
  NonText      = { fg = medium_gray },
  EndOfBuffer  = { fg = gray },
  Comment      = { fg = gray, italic = true },
  Title        = { fg = lavender, bold = true },
  Todo         = { fg = dark_gray, bg = yellow, bold = true },
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
  Keyword  = { fg = off_white },
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

  DiffAdd = { bg = dark_gray, fg = green },
  DiffChange = { bg = dark_gray, fg = yellow },
  DiffDelete = { bg = dark_gray, fg = red },
  DiffText = { bg = medium_gray, fg = yellow },

  -- Cmp / Blink
  BlinkCmpLabelMatch = { fg = orange },

  -- Checkhealth
  healthSuccess = { fg = green, bg = black },

  --- Fugitive
  diffAdded = { link = "DiffAdd" },
  diffRemoved = { link = "DiffDelete" },

  --- Statusline
  StatuslineAdd = { fg = green, bg = dark_gray },
  StatuslineErr = { fg = red, bg = dark_gray },
  StatuslineHint = { fg = blue, bg = dark_gray },
  StatuslineInfo = { fg = green, bg = dark_gray },
  StatuslineWarn = { fg = yellow, bg = dark_gray },
  StatuslineBlue = { fg = ansi.blue, bg = dark_gray },
  StatuslineRed = { fg = ansi.red, bg = dark_gray },
  StatuslineGreen = { fg = ansi.green, bg = dark_gray },
  StatuslineCyan = { fg = bright.cyan, bg = dark_gray },
  StatuslineMagenta = { fg = ansi.pink, bg = dark_gray },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
