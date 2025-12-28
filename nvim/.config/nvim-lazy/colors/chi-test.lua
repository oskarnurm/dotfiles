---@param color string
local function color_to_rgb(color)
  local function byte(value, offset)
    return bit.band(bit.rshift(value, offset), 0xFF)
  end

  local new_color = vim.api.nvim_get_color_by_name(color)
  if new_color == -1 then
    new_color = vim.opt.background:get() == "dark" and 000 or 255255255
  end

  return { byte(new_color, 16), byte(new_color, 8), byte(new_color, 0) }
end

--- Blends two colors based on alpha transparency.
--- Adapted from: https://github.com/rose-pine/neovim/blob/main/lua/rose-pine/utilities.lua
--- Original license: MIT
---@param color string Color to blend
---@param base_color string Base color to blend on
---@param alpha number Between 0 (background) and 1 (foreground)
---@return string # A hex color string like "#RRGGBB"
function blend(color, base_color, alpha)
  local fg_rgb = color_to_rgb(color)
  local bg_rgb = color_to_rgb(base_color)

  local function blend_channel(i)
    local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  local result = string.format("#%02X%02X%02X", blend_channel(1), blend_channel(2), blend_channel(3))

  return result
end

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chiefdog"

-- TODO: add lightheme
-- stylua: ignore
local c = {
  transparent = "none",
  bg          = "#101010",
  fg          = "#b0b0b0",
  comment     = "#50585D",
  line        = "#444444",
  keyword     = "#777777",
  definition  = "#ffffff",
  constant    = "#d9ba73",
  hint        = "#8ebeec",
  cursor      = "#272727",
  selection   = "#303030", -- TODO: find something better
  search      = "#333333",
  error       = "#ff7676",
  -- TODO: reuse the existing colors
  add         = "#86CD82",
  change      = "#d9ba73",
  delete      = "#ff7676",
}

-- stylua: ignore
local groups = {
  Normal       = { bg = c.bg, fg = c.fg },
  NormalFloat  = { bg = c.bg, fg = c.fg },
  FloatBorder  = { bg = c.bg, fg = c.line },
  Cursor       = { bg = "#ffffff", fg = c.bg },
  CursorLine   = { bg = c.cursor },
  CursorLineNr = { fg = c.definition, bold = true },
  LineNr       = { fg = c.line },
  StatusLine   = { bg = c.line },
  StatusLineNC = { bg = c.bg, fg = c.fg },
  StatusLineTerm = { bg = c.cursor, fg = c.fg },
  StatusLineTermNC = { bg = c.bg, fg = c.line },
  WinBar       = { bg = c.bg, fg = c.fg, bold = true },
  WinBarNC     = { bg = c.bg, fg = c.line },
  WinSeparator = { fg = c.line },
  Pmenu        = { bg = c.cursor, fg = c.fg },
  PmenuSel     = { bg = c.line, fg = c.definition, bold = true },
  PmenuThumb   = { bg = c.fg },
  Visual       = { bg = c.selection },
  Search       = { bg = c.constant, fg = c.bg },
  IncSearch    = { link = "Search" },
  CurSearch    = { link = "Search" },
  MatchParen   = { fg = c.fg, bg = c.line },
  NonText      = { fg = c.cursor },
  EndOfBuffer  = { fg = c.bg },
  Question     = { fg = c.constant },
  MoreMsg      = { fg = c.constant },
  ErrorMsg     = { fg = c.error },
  WarningMsg   = { fg = c.constant },
  ModeMsg      = { fg = c.constant },
  Directory    = { fg = c.hint },
  QuickFixLine = { fg = c.constant, underline = true },
  qfLineNr     = { fg = c.line },

  -- Syntax
  Keyword      = { fg = c.keyword },
  Conditional  = { link = "Keyword" },
  Repeat       = { link = "Keyword" },
  Label        = { link = "Keyword" },
  Exception    = { link = "Keyword" },
  Statement    = { link = "Keyword" },
  Operator     = { link = "Keyword" },
  Delimiter    = { fg = c.definition },
  Type         = { link = "Keyword" },
  Structure    = { link = "Keyword" },
  Identifier   = { fg = c.fg },
  PreProc      = { link = "Keyword" },
  Include      = { link = "Keyword" },
  Define       = { link = "Keyword" },
  PreCondit    = { link = "Keyword" },
  StorageClass = { link = "Keyword" },
  Typedef      = { link = "Keyword" },
  Tag          = { link = "Keyword" },
  Function     = { fg = c.definition, bold = true },
  Title        = { fg = c.definition, bold = true },
  String       = { fg = c.definition, italic = false },
  Character    = { link = "String" },
  Number       = { fg = c.constant },
  Boolean      = { fg = c.constant },
  Float        = { fg = c.constant },
  Constant     = { fg = c.constant },
  Macro        = { fg = c.constant },
  Comment      = { fg = c.comment, italic = true },
  Todo         = { fg = c.bg, bg = c.constant, bold = true },
  Special      = { fg = c.fg },
  SpecialChar  = { link = "Special" },
  SpecialComment = { link = "Comment" },
  Underlined   = { underline = true },
  Error        = { fg = c.error },
  Debug        = { fg = c.constant },

  -- Treesitter
  ["@function"]              = { link = "Function" },
  ["@function.call"]         = { fg = c.fg },
  ["@function.builtin"]      = { fg = c.fg },
  ["@function.macro"]        = { link = "Macro" },
  ["@function.method"]       = { link = "Function" },
  ["@function.method.call"]  = { fg = c.fg },

  ["@keyword"]               = { link = "Keyword" },
  ["@keyword.function"]      = { link = "Keyword" },
  ["@keyword.return"]        = { fg = c.definition },
  ["@keyword.conditional"]   = { link = "Conditional" },
  ["@keyword.exception"]     = { link = "Exception" },
  ["@keyword.import"]        = { link = "Include" },
  ["@keyword.operator"]      = { link = "Operator" },
  ["@operator"]              = { link = "Operator" },
  ["@punctuation"]           = { link = "Keyword" },
  ["@punctuation.delimiter"] = { fg = c.definition },
  ["@punctuation.bracket"]   = { fg = c.definition },
  ["@punctuation.special"]   = { fg = c.definition },

  ["@variable"]              = { link = "Identifier" },
  ["@variable.builtin"]      = { link = "Constant" },
  ["@variable.parameter"]    = { link = "Identifier" },
  ["@variable.member"]       = { link = "Identifier" },
  ["@property"]              = { link = "Identifier" },
  ["@attribute"]             = { link = "Keyword" },
  ["@module"]                = { link = "Structure" },

  ["@constant"]              = { link = "Constant" },
  ["@constant.builtin"]      = { link = "Constant" },
  ["@string"]                = { link = "String" },
  ["@string.regexp"]         = { link = "String" },
  ["@string.escape"]         = { link = "Special" },
  ["@string.special"]        = { link = "Special" },
  ["@character"]             = { link = "Character" },
  ["@number"]                = { link = "Number" },
  ["@boolean"]               = { link = "Boolean" },
  ["@constructor"]           = { link = "Identifier" },

  ["@tag"]                   = { link = "Keyword" },
  ["@tag.delimiter"]         = { link = "Keyword" },
  ["@tag.attribute"]         = { link = "Keyword" },

  ["@markup.heading"]        = { link = "Title" },
  ["@markup.italic"]         = { fg = c.fg, italic = true },
  ["@markup.strong"]         = { fg = c.fg, bold = true },
  ["@markup.link"]           = { link = "Underlined" },
  ["@markup.link.uri"]       = { link = "Underlined" },
  ["@markup.list"]           = { fg = c.constant },
  ["@markup.raw"]            = { link = "Constant" },
  ["@markup.quote"]          = { link = "Comment" },

  -- Diff / Git
  DiffAdd       = { fg = c.add, bg = blend(c.add, c.bg, 0.2) },
  DiffChange    = { fg = c.change, bg = blend(c.change, c.bg, 0.2) },
  DiffDelete    = { fg = c.delete, bg = blend(c.delete, c.bg, 0.2) },
  DiffText      = { fg = c.change, bg = blend(c.change, c.bg, 0.4) },

  ["@text.diff.add"]    = { link = "DiffAdd" },
  ["@text.diff.delete"] = { link = "DiffDelete" },
  ["@diff.plus"]        = { link = "GitSignsAdd" },
  ["@diff.minus"]       = { link = "GitSignsDelete" },
  ["@diff.delta"]       = { link = "GitSignsChange" },

  -- Diagnostics
  DiagnosticError = { fg = c.error },
  DiagnosticWarn  = { fg = c.constant },
  DiagnosticHint  = { fg = c.hint },
  DiagnosticInfo  = { fg = c.fg },

  -- Gitsigns
  GitSignsAdd    = { fg = c.add },
  GitSignsChange = { fg = c.change },
  GitSignsDelete = { fg = c.delete },

  -- Blink
  BlinkCmpLabelMatch = { fg = c.constant },

  -- Mini.pick
  MiniPickMatchRanges = { fg = c.constant },

  -- Oil
  OilCreate = { fg = c.add },

  -- Snacks
  SnacksPickerDir = { fg = c.keyword },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
