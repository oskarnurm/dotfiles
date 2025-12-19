vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chiefdog"

local night = "#121212" -- Background
local platinum = "#DDDDDD" -- Foreground
local silver = "#CCCCCC" -- Variables
local smoke = "#F2F2F2" -- Brighter (properties)
local muted = "#7F7F7F" -- Comments/Delimiters
local raisin = "#272727" -- UI Backgrounds (Statusline, CursorLine)
local charcoal = "#525252" -- Lighter UI (PmenuSel)
local lavender = "#CFCFEA" -- Types, Structure, Tags
local jordy = "#8EBEEC" -- Hints, Directories
local pistachio = "#86CD82" -- Strings, Success
local straw = "#DFDF8E" --  Numbers, Return
local earth = "#E9B872" --  Functions, Attributes
local bittersweet = "#FE5F55" -- Errors
local cinnabar = "#FE4134"
local rose = "#ffa69e"
local orchid = "#D4ADCF"
local teal = "#037171"

vim.g.terminal_color_0 = "#121122"
vim.g.terminal_color_1 = "#FE4134"
vim.g.terminal_color_2 = "#72C56D"
vim.g.terminal_color_3 = "#D7D770"
vim.g.terminal_color_4 = "#62A5E4"
vim.g.terminal_color_5 = "#C794C0"
vim.g.terminal_color_6 = "#049F9F"
vim.g.terminal_color_7 = "#CCCCCC"
vim.g.terminal_color_8 = "#272727"
vim.g.terminal_color_9 = "#FE5F55"
vim.g.terminal_color_10 = "#86CD82"
vim.g.terminal_color_11 = "#DFDF8E"
vim.g.terminal_color_12 = "#8EBEEC"
vim.g.terminal_color_13 = "#D4ADCF"
vim.g.terminal_color_14 = "#037171"
vim.g.terminal_color_15 = "#F2F2F2"

local groups = {
  Normal = { bg = night, fg = platinum },
  NormalFloat = { bg = "none" },
  FloatBorder = { bg = "none", fg = platinum },
  Cursor = { bg = smoke, fg = raisin },
  CursorLine = { bg = raisin },
  CursorColumn = { bg = raisin },
  ColorColumn = { bg = raisin },
  LineNr = { fg = muted },
  CursorLineNr = { fg = jordy, bold = true },
  VertSplit = { fg = charcoal },
  StatusLine = { bg = raisin, fg = platinum },
  StatusLineNC = { bg = raisin, fg = "none" },
  WinBar = { bg = night, fg = smoke, bold = true },
  WinBarNC = { bg = night, fg = muted },
  Directory = { fg = jordy },
  Pmenu = { bg = "none" },
  PmenuSel = { bg = charcoal },
  PmenuSbar = { bg = charcoal },
  PmenuThumb = { bg = charcoal },
  Visual = { bg = charcoal }, -- Visual selection
  Search = { bg = charcoal },
  IncSearch = { link = "Search" },
  CurSearch = { fg = earth, bg = raisin },
  MatchParen = { bg = muted, fg = raisin },
  NonText = { fg = charcoal },
  EndOfBuffer = { fg = muted },
  Comment = { fg = muted, italic = true },
  Title = { fg = lavender, bold = true },
  Todo = { fg = raisin, bg = straw, bold = true },
  Conceal = { fg = muted }, -- Make hidden chars subtle
  Underlined = { underline = true }, -- HTML links
  Special = { fg = jordy }, -- Special characters (regex, etc.)

  -- "Confirmation" text (Save? Yes/No)
  Question = { fg = straw, bold = true },
  MoreMsg = { fg = straw, bold = true },
  ErrorMsg = { fg = bittersweet, bold = true },
  WarningMsg = { fg = straw, bold = true },
  ModeMsg = { fg = straw, bold = true },

  QuickFixLine = { bg = "none", fg = straw },
  qfLineNr = { fg = muted },

  -- Keywords & Operators (Muted)
  Keyword = { fg = smoke, bold = true }, -- "function", "return"
  Operator = { fg = smoke, bold = true },
  ["@keyword.return"] = { fg = straw }, -- Special return color

  -- Functions (Action -> Earth/Brighter colors)
  Function = { fg = orchid },
  ["@function"] = { fg = smoke, bold = true }, -- Definition
  ["@function.call"] = { fg = orchid }, -- Invocation

  -- Variables (Data -> Silver/White colors)
  ["@variable"] = { fg = silver },
  ["@variable.member"] = { fg = smoke }, -- Properties (inter.className)
  ["@property"] = { fg = smoke },

  -- Types
  ["@type"] = { fg = lavender }, -- User Types
  ["@type.builtin"] = { fg = lavender }, -- string, boolean
  ["@constructor"] = { fg = lavender }, -- new User()

  -- Constant
  ["@string"] = { fg = pistachio, italic = true },
  ["@number"] = { fg = straw },
  ["@boolean"] = { fg = straw },
  ["@constant"] = { fg = lavender }, -- NONE, nil

  -- HTML/JSX Tags
  ["@tag"] = { fg = lavender },
  ["@tag.builtin"] = { fg = lavender },
  ["@tag.attribute"] = { fg = silver }, --'className=', 'lang=', 'key='
  ["@tag.delimiter"] = { fg = muted },

  -- Punctuation (Muted)
  ["@punctuation.delimiter"] = { fg = smoke },
  ["@punctuation.bracket"] = { fg = muted },
  ["@punctuation.member"] = { fg = muted },
  ["@punctuation.special"] = { fg = muted },
  ["@punctuation.section.embedded"] = { fg = muted },

  -- DIAGNOSTICS & GIT
  DiagnosticError = { fg = bittersweet },
  DiagnosticWarn = { fg = earth },
  DiagnosticHint = { fg = jordy },
  DiagnosticInfo = { fg = pistachio },

  DiagnosticVirtualTextError = { bg = "none", fg = bittersweet },
  DiagnosticVirtualTextWarn = { bg = "none", fg = earth },
  DiagnosticVirtualTextHint = { bg = "none", fg = jordy },
  DiagnosticVirtualTextInfo = { bg = "none", fg = pistachio },

  GitSignsAdd = { fg = pistachio },
  GitSignsChange = { fg = straw },
  GitSignsDelete = { fg = bittersweet },

  DiffAdd = { bg = raisin, fg = pistachio },
  DiffChange = { bg = raisin, fg = straw },
  DiffDelete = { bg = raisin, fg = bittersweet },
  DiffText = { bg = charcoal, fg = straw },

  -- PLUGINS
  --
  -- Cmp / Blink
  BlinkCmpLabelMatch = { fg = earth },

  -- Checkhealth
  healthSuccess = { fg = pistachio, bg = night },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
