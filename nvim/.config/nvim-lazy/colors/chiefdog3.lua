vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chiefdog"

-- stylya: ignore
-- Colors
local c = {
  transparent = "none",
  bg = "#101010",
  comment = "#444444",
  text = "#b0b0b0", -- Keywords, Logic, Punctuation
  definition = "#ffffff", -- Function names, Important variables
  string = "#86CD82",
  constant = "#d9ba73", -- Numbers, Booleans
  cursor = "#272727",
  selection = "#222E58",
  search = "#333333",
  error = "#ff7676",
  hint = "#2e2e2e",
  add = "#26332c",
  delete = "#332626",
  change = "#262e33",
}

local groups = {
  -- Basic
  Normal = { bg = c.bg, fg = c.text },
  NormalFloat = { bg = c.bg, fg = c.text },
  FloatBorder = { bg = c.bg, fg = c.comment },
  Cursor = { bg = "#ffffff", fg = c.bg },
  CursorLine = { bg = c.cursor },
  CursorLineNr = { fg = c.definition, bold = true },
  LineNr = { fg = c.comment },
  StatusLine = { bg = c.cursor, fg = c.text },
  StatusLineNC = { bg = c.bg, fg = c.comment },
  WinBar = { bg = c.bg, fg = c.text, bold = true },
  WinBarNC = { bg = c.bg, fg = c.comment },
  Pmenu = { bg = c.cursor, fg = c.text },
  PmenuSel = { bg = c.comment, fg = c.definition, bold = true },
  PmenuThumb = { bg = c.text },
  Visual = { bg = c.selection },
  Search = { bg = c.constant, fg = c.bg },
  IncSearch = { link = "Search" },
  CurSearch = { link = "Search" },
  MatchParen = { fg = c.definition, bold = true, underline = true },
  NonText = { fg = c.cursor },
  EndOfBuffer = { fg = c.bg },

  -- Syntax
  Keyword = { fg = c.text },
  Conditional = { link = "Keyword" },
  Repeat = { link = "Keyword" },
  Label = { link = "Keyword" },
  Exception = { link = "Keyword" },
  Statement = { link = "Keyword" },
  Operator = { link = "Keyword" }, -- +, -, =, etc.
  Delimiter = { link = "Keyword" }, -- {}, [], ()
  Type = { link = "Keyword" }, -- int, string, void
  Structure = { link = "Keyword" }, -- struct, class
  Identifier = { link = "Keyword" }, -- variables
  PreProc = { link = "Keyword" }, -- #include, imports
  Function = { fg = c.definition, bold = true },
  Title = { fg = c.definition, bold = true },
  String = { fg = c.string },
  Character = { link = "String" },
  Number = { fg = c.constant },
  Boolean = { fg = c.constant },
  Float = { fg = c.constant },
  Constant = { fg = c.constant }, -- NIL, TRUE, specialized constants
  Comment = { fg = c.comment, italic = true },
  Todo = { fg = c.bg, bg = c.constant, bold = true }, -- Pop out TODOs
  Special = { fg = c.text }, -- Regex chars etc. (Keep muted or accent?)
  Underlined = { underline = true },
  Error = { fg = c.error },
  ErrorMsg = { fg = c.error },

  ["@function"] = { link = "Function" }, -- Definition name
  ["@function.call"] = { link = "Keyword" }, -- Function invocation (Muted!)
  ["@function.builtin"] = { link = "Keyword" }, -- print, require (Muted)
  ["@function.macro"] = { link = "Keyword" },
  ["@function.method"] = { link = "Function" },
  ["@function.method.call"] = { link = "Keyword" },
  ["@keyword"] = { link = "Keyword" },
  ["@keyword.function"] = { link = "Keyword" }, -- "local function" text
  ["@keyword.return"] = { link = "Keyword" }, -- "return"
  ["@operator"] = { link = "Keyword" },
  ["@punctuation"] = { link = "Keyword" },
  ["@punctuation.delimiter"] = { link = "Keyword" },
  ["@punctuation.bracket"] = { link = "Keyword" },
  ["@variable"] = { link = "Keyword" },
  ["@variable.builtin"] = { link = "Constant" }, -- 'self', 'this' (Optional: make these pop?)
  ["@variable.parameter"] = { link = "Keyword" }, -- Arguments are plain
  ["@variable.member"] = { link = "Keyword" }, -- object.property
  ["@constant"] = { link = "Constant" },
  ["@constant.builtin"] = { link = "Constant" },
  ["@string"] = { link = "String" },
  ["@number"] = { link = "Number" },
  ["@boolean"] = { link = "Boolean" },
  -- Tags (HTML/JSX) - Keep minimal
  ["@tag"] = { link = "Keyword" },
  ["@tag.delimiter"] = { link = "Keyword" },
  ["@tag.attribute"] = { link = "Keyword" }, -- Attributes plain

  -- Diff / Git
  DiffAdd = { bg = c.add },
  DiffChange = { bg = c.change },
  DiffDelete = { bg = c.delete },

  GitSignsAdd = { fg = c.string },
  GitSignsChange = { fg = c.constant },
  GitSignsDelete = { fg = c.error },

  -- Diagnostics
  DiagnosticError = { fg = c.error },
  DiagnosticWarn = { fg = c.constant },
  DiagnosticHint = { fg = c.comment },
  DiagnosticInfo = { fg = c.text },
}

for group, hl in pairs(groups) do
  vim.api.nvim_set_hl(0, group, hl)
end
