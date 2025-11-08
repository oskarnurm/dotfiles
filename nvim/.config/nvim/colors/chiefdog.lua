vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "chiefdog"

local theme
if vim.o.background == "dark" then
  -- terminal colors
  vim.g.terminal_color_0 = "#000000"
  vim.g.terminal_color_1 = "#d2322d"
  vim.g.terminal_color_2 = "#6abf40"
  vim.g.terminal_color_3 = "#cd974b"
  vim.g.terminal_color_4 = "#217EBC"
  vim.g.terminal_color_5 = "#9B3596"
  vim.g.terminal_color_6 = "#178F79"
  vim.g.terminal_color_7 = "#cecece"
  vim.g.terminal_color_8 = "#333333"
  vim.g.terminal_color_9 = "#c33c33"
  vim.g.terminal_color_10 = "#95cb82"
  vim.g.terminal_color_11 = "#dfdf8e"
  vim.g.terminal_color_12 = "#71aed7"
  vim.g.terminal_color_13 = "#cc8bc9"
  vim.g.terminal_color_14 = "#47BEA9"
  vim.g.terminal_color_15 = "#ffffff"

  -- colors
  local night = "#121212"
  local platinum = "#dddddd"
  local silver = "#cccccc"
  local lavender = "#CFCFEA"
  local smoke = "#F2F2F2"
  local jordy = "#8ebeec"
  local pistachio = "#86CD82"
  -- local pistachio_bright = "#88cc66"
  local straw = "#dfdf8e"
  local earth = "#E9B872"
  local bittersweet = "#FE5F55"
  local raisin = "#272727"
  local onyx = "#525252" -- lighter raising
  local gray = "#7F7F7F"

  local bg = night
  local fg = platinum

  local diffadd = pistachio
  local diffdelete = bittersweet
  local diffchange = straw

  local declaration = smoke
  local statusline = raisin
  local comment = gray

  local error = bittersweet
  local warn = earth
  local hint = jordy
  local info = pistachio
  local comment_fg = straw

  local ansi = {
    black = night,
    blue = jordy,
    brightyellow = straw,
    cyan = "#47bea9",
    green = pistachio,
    magenta = "#cc8bc9",
    red = bittersweet,
    white = smoke,
    yellow = earth,
  }

  -- TODO: need to tweak these
  local darker_fg = "#7d7d7d"

  theme = {
    -- Theme specific
    ["@chiefdog.base"] = { fg = fg },
    ["@chiefdog.variable"] = { fg = silver },
    ["@chiefdog.green"] = { fg = pistachio },
    ["@chiefdog.marker"] = { fg = comment_fg },
    ["@chiefdog.declaration"] = { fg = declaration, bold = true },
    ["@chiefdog.function.call"] = { fg = earth },
    ["@chiefdog.muted"] = { fg = declaration },
    ["@chiefdog.positive"] = { fg = pistachio, bg = "#1a2a18" },
    ["@chiefdog.positive.foreground"] = { fg = pistachio },
    ["@chiefdog.positive.background"] = { bg = "#1a2a18" },
    ["@chiefdog.negative"] = { fg = declaration, bg = "#2a2a2a" },
    ["@chiefdog.negative.foreground"] = { fg = declaration },
    ["@chiefdog.negative.background"] = { bg = "#2a2a2a" },
    ["@chiefdog.highlight"] = { fg = comment_fg, bg = "#3f3f28" },
    ["@chiefdog.highlight.foreground"] = { fg = comment_fg },
    ["@chiefdog.highlight.background"] = { bg = "#3f3f28" },
    ["@chiefdog.return"] = { fg = straw },
    -- Base
    ["@function"] = { link = "@chiefdog.declaration" },
    ["@function.call"] = { link = "@chiefdog.function.call" },
    ["@variable"] = { link = "@chiefdog.variable" },
    ["@property"] = { link = "@chiefdog.base" },
    ["@type"] = { link = "@chiefdog.base" },
    ["@comment.documentation"] = { fg = comment },
    Special = { link = "@chiefdog.base" },
    -- Variables
    ["@string"] = { link = "@chiefdog.green" },
    ["@character"] = { link = "@chiefdog.green" },
    ["@number"] = { link = "@chiefdog.green" },
    ["@boolean"] = { link = "@chiefdog.green" },
    -- Muted
    ["@keyword"] = { link = "@chiefdog.muted" },
    ["@punctuation.delimeter"] = { link = "@chiefdog.muted" },
    ["@punctuation.bracket"] = { link = "@chiefdog.muted" },
    ["@punctuation.special"] = { link = "@chiefdog.muted" },
    Operator = { link = "@chiefdog.muted" },
    -- Markers
    ["@keyword.return"] = { link = "@chiefdog.return" },
    Comment = { fg = comment },
    -- ["@local.definition"] = { link = "@chiefdog.declaration" },
    -- UI
    Search = { link = "@chiefdog.highlight.background" },
    CurSearch = { link = "@chiefdog.highlight" },
    Visual = { link = "Search" },
    IncSearch = { link = "Search" },
    -- New Code Ended
    Function = { link = "@chiefdog.declaration" },
    ColorColumn = { bg = "#182325" },
    Conceal = { fg = "#b0b0b0" },
    Cursor = { bg = smoke, fg = raisin },
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = raisin },
    CursorLine = { bg = raisin },
    Directory = { fg = ansi.blue },
    DiffAdd = { link = "@chiefdog.positive.background" },
    DiffDelete = { link = "@chiefdog.negative" },
    DiffChange = { link = "@chiefdog.positive.background" },
    DiffText = { link = "@chiefdog.highlight" },
    EndOfBuffer = { fg = "#354c50" },
    -- TermCursor   { }, -- cursor in a focused terminal
    TermCursorNC = { fg = bg, bg = fg },
    ErrorMsg = { link = "@chiefdog.highlight.foreground" },
    VertSplit = { fg = "#2b3d40" },
    Folded = { bg = "#182325", fg = "#7d7d7d" },
    FoldColumn = { bg = bg, fg = "#4d4d4d" },
    SignColumn = {},
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    LineNr = { fg = "#5c5c5c" },
    CursorLineNr = { fg = jordy, bold = 1 },
    MatchParen = { bg = gray, fg = raisin },
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = ansi.green, bold = 1 },
    NonText = { fg = "#696969" },
    Normal = { bg = bg, fg = fg },
    NormalFloat = { bg = "none" },
    FloatBorder = { fg = fg, bg = "none" },
    Pmenu = { bg = "none" },
    PmenuSel = { bg = onyx },
    PmenuSbar = { bg = onyx },
    PmenuThumb = { bg = onyx },
    Question = { fg = diffadd },
    QuickFixLine = { bg = "#182325" },
    SpellBad = { undercurl = 1, sp = ansi.red },
    SpellCap = { undercurl = 1, sp = ansi.blue },
    SpellLocal = { undercurl = 1, sp = ansi.cyan },
    SpellRare = { undercurl = 1, sp = ansi.magenta },
    StatusLine = { bg = statusline, fg = fg },
    -- StatusLineNC = { bg = statusline, fg = "#9f9f9f" },
    StatusLineNC = { bg = statusline, fg = "none" },
    TabLine = { bg = statusline, fg = "#7d7d7d" },
    TabLineFill = { bg = statusline },
    TabLineSel = { bg = statusline, fg = ansi.blue },
    Title = { fg = lavender },
    VisualNOS = { bg = "#293334" },
    WarningMsg = { fg = "#e1ad4c" },
    WildMenu = { bg = "#354c50" },
    WinBar = { bg = bg, fg = ansi.white, bold = true },
    WinBarNC = { bg = bg, fg = "#7d7d7d" },

    SpecialComment = { bg = "#1d292b", fg = ansi.blue },
    debugPc = { bg = "#0f2534" },
    debugBreakpoint = { bg = "#b33229" },
    helpHyperTextJump = { fg = ansi.magenta },
    helpSectionDelim = { fg = ansi.magenta },
    helpExample = { fg = ansi.cyan },
    helpCommand = { fg = ansi.cyan },
    helpHeadline = { fg = ansi.blue },
    helpHeader = { fg = ansi.magenta },

    Underlined = { underline = 1 }, -- (preferred) text that stands out, HTML links
    Italic = { italic = 1 },

    -- ("Ignore", below, may be invisible...)
    -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { link = "@chiefdog.highlight.foreground" },
    Todo = { bg = straw, fg = bg },

    --- Diagnostic
    LspReferenceText = { bg = "#253437" },
    LspReferenceRead = { bg = "#253437" },
    LspReferenceWrite = { bg = "#253437", underline = 1, sp = earth },
    LspCodeLens = { fg = "#5c5c5c" },
    LspCodeLensSeparator = { fg = "#5c5c5c" },

    --- Diagnostic
    DiagnosticError = { link = "@chiefdog.highlight.foreground" },
    DiagnosticWarn = { fg = warn },
    DiagnosticHint = { fg = hint },
    DiagnosticInfo = { fg = info },
    DiagnosticVirtualTextError = { bg = "none", fg = "#D1503A" },
    DiagnosticVirtualTextWarn = { bg = "none", fg = "#C8935D" },
    DiagnosticVirtualTextHint = { bg = "none", fg = "#7E9CB9" },
    DiagnosticVirtualTextInfo = { bg = "none", fg = "#7BAC62" },

    ["@error"] = { link = "@chiefdog.highlight.foreground" },
    ["@tag.delimiter"] = { fg = declaration },
    ["@text.note"] = { bg = "#1d292b", fg = ansi.blue },
    ["@text.warning"] = { bg = straw, fg = bg },

    --- Gitsigns
    GitSignsAdd = { fg = diffadd },
    GitSignsChange = { fg = diffchange },
    GitSignsDelete = { fg = diffdelete },
    --- Blink
    BlinkCmpLabelMatch = { fg = earth },
    --- Fugitive
    diffAdded = { link = "DiffAdd" },
    diffRemoved = { link = "DiffDelete" },
    --- Statusline
    StatuslineAdd = { fg = diffadd, bg = statusline },
    StatuslineErr = { fg = error, bg = statusline },
    StatuslineHint = { fg = hint, bg = statusline },
    StatuslineInfo = { fg = info, bg = statusline },
    StatuslineWarn = { fg = warn, bg = statusline },
    StatuslineBlue = { fg = ansi.blue, bg = statusline },
    StatuslineRed = { fg = ansi.red, bg = statusline },
    StatuslineGreen = { fg = ansi.green, bg = statusline },
    StatuslineCyan = { fg = ansi.cyan, bg = statusline },
    StatuslineMagenta = { fg = ansi.magenta, bg = statusline },
    --- ALE
    ALEWarningSign = { fg = warn },
    --- For `highlight link`
    ["chiefdog.black"] = { fg = ansi.black },
    ["chiefdog.blue"] = { fg = ansi.blue },
    ["chiefdog.brightyellow"] = { fg = ansi.brightyellow },
    ["chiefdog.cyan"] = { fg = ansi.cyan },
    ["chiefdog.green"] = { fg = ansi.green },
    ["chiefdog.darkGreen"] = { fg = "#6abf40" },
    ["chiefdog.magenta"] = { fg = ansi.magenta },
    ["chiefdog.red"] = { fg = ansi.red },
    ["chiefdog.white"] = { fg = ansi.white },
    ["chiefdog.yellow"] = { fg = ansi.yellow },
    --- checkhealth
    healthSuccess = { fg = ansi.green, bg = bg },
  }
end

for group, hl in pairs(theme) do
  vim.api.nvim_set_hl(0, group, hl)
end
