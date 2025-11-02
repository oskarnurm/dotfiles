vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

-- My own modified theme using y9nika as a base under the MIT license
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
  local bg = "#121212"
  local fg = "#dddddd"
  local muted_fg = "#aaaaaa"
  local def_fg = "#71ade7"
  local const_fg = "#95cb82"
  local comment = "#dfdf8e"
  local return_fg = "#dfdf8e"
  local keyword = "#aaaaaa"
  local active = "#cd974b"
  local string_fg = "#95cb82"
  local darker_fg = "#7d7d7d"
  local diffadd = const_fg
  local diffdelete = "#d13e23"
  local diffchange = comment
  local statusline = "#162022"
  -- local statusline = "none"
  local dim_comment = "#696969"
  local mistake = {
    fg = "#c33c33",
    bg = "#2b1d1e",
  }
  local error = "#d13e23"
  local warn = "#f4b371"
  local hint = "#8ebeec"
  local info = "#88cc66"
  local ansi = {
    black = "#333333",
    blue = "#71aed7",
    brightyellow = "#dfdf8e",
    cyan = "#47bea9",
    green = "#95cb82",
    magenta = "#cc8bc9",
    red = "#c33c33",
    white = "#cecece",
    yellow = "#cd974b",
  }
  local comment_fg = comment
  -- local pmenu_bg = "#182325"
  local float_bg = pmenu_bg
  local floatborder = {
    bg = float_bg,
    fg = float_bg,
  }
  theme = {
    -- Theme specific
    ["@chiefdog.base"] = { fg = fg },
    ["@chiefdog.variable"] = { fg = const_fg },
    ["@chiefdog.marker"] = { fg = comment_fg },
    ["@chiefdog.declaration"] = { fg = keyword, bold = true },
    ["@chiefdog.function.call"] = { fg = active },
    ["@chiefdog.muted"] = { fg = muted_fg },
    ["@chiefdog.positive"] = { fg = const_fg, bg = "#1a2a18" },
    ["@chiefdog.positive.foreground"] = { fg = const_fg },
    ["@chiefdog.positive.background"] = { bg = "#1a2a18" },
    ["@chiefdog.negative"] = { fg = muted_fg, bg = "#2a2a2a" },
    ["@chiefdog.negative.foreground"] = { fg = muted_fg },
    ["@chiefdog.negative.background"] = { bg = "#2a2a2a" },
    ["@chiefdog.highlight"] = { fg = comment_fg, bg = "#3f3f28" },
    ["@chiefdog.highlight.foreground"] = { fg = comment_fg },
    ["@chiefdog.highlight.background"] = { bg = "#3f3f28" },
    ["@chiefdog.return"] = { fg = return_fg },
    -- Base
    ["@function"] = { link = "@chiefdog.declaration" },
    ["@function.call"] = { link = "@chiefdog.function.call" },
    ["@variable"] = { link = "@chiefdog.base" },
    ["@property"] = { link = "@chiefdog.base" },
    ["@type"] = { link = "@chiefdog.base" },
    Special = { link = "@chiefdog.base" },
    -- Variables
    ["@string"] = { link = "@chiefdog.variable" },
    ["@character"] = { link = "@chiefdog.variable" },
    ["@number"] = { link = "@chiefdog.variable" },
    ["@boolean"] = { link = "@chiefdog.variable" },
    -- Muted
    ["@keyword"] = { link = "@chiefdog.muted" },
    ["@punctuation.delimeter"] = { link = "@chiefdog.muted" },
    ["@punctuation.bracket"] = { link = "@chiefdog.muted" },
    ["@punctuation.special"] = { link = "@chiefdog.muted" },
    Operator = { link = "@chiefdog.muted" },
    -- Markers
    ["@keyword.return"] = { link = "@chiefdog.return" },
    Comment = { link = "@chiefdog.marker" },
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
    Cursor = { bg = active, fg = "#000000" },
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = "#282828" },
    CursorLine = { bg = "#282828" },
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
    CursorLineNr = { fg = ansi.blue, bold = 1 },
    MatchParen = { underline = 1, sp = active },
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = ansi.green, bold = 1 },
    NonText = { fg = "#696969" },
    Normal = { bg = bg, fg = fg },
    NormalFloat = { bg = bg },
    -- NormalNC     { }, -- normal text in non-current windows
    FloatBorder = floatborder,
    Pmenu = { bg = pmenu_bg },
    PmenuSel = { bg = "#354c50" },
    PmenuSbar = { bg = "#212f31" },
    PmenuThumb = { bg = "#47666b" },
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
    Title = { fg = def_fg },
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

    Todo = { bg = "#d0d058", fg = bg },

    --- Diagnostic
    LspReferenceText = { bg = "#253437" },
    LspReferenceRead = { bg = "#253437" },
    LspReferenceWrite = { bg = "#253437", underline = 1, sp = active },
    LspCodeLens = { fg = "#5c5c5c" },
    LspCodeLensSeparator = { fg = "#5c5c5c" },

    --- Diagnostic
    DiagnosticError = { link = "@chiefdog.highlight.foreground" },
    DiagnosticWarn = { fg = warn },
    DiagnosticHint = { fg = hint },
    DiagnosticInfo = { fg = info },
    DiagnosticVirtualTextError = { bg = "#350B0B", fg = "#D1503A" },
    DiagnosticVirtualTextWarn = { bg = "#3F240A", fg = "#C8935D" },
    DiagnosticVirtualTextHint = { bg = "#1D2B37", fg = "#7E9CB9" },
    DiagnosticVirtualTextInfo = { bg = "#162C0B", fg = "#7BAC62" },

    ["@error"] = { link = "@chiefdog.highlight.foreground" },
    ["@tag.delimiter"] = { fg = muted_fg },
    ["@text.note"] = { bg = "#1d292b", fg = ansi.blue },
    ["@text.warning"] = { bg = "#d0d058", fg = bg },

    --- Gitsigns
    GitSignsAdd = { fg = diffadd },
    GitSignsChange = { fg = diffchange },
    GitSignsDelete = { fg = diffdelete },
    --- Telescope
    TelescopeBorder = { fg = "#2b3d40" },
    TelescopeMatching = { link = "Search" },
    TelescopeSelection = { link = "Search" },
    TelescopePreviewMatch = { link = "Search" },
    TelescopePreviewLine = { link = "Search" },
    TelescopeMultiSelection = { link = "Search" },
    TelescopePromptPrefix = { fg = ansi.blue },
    TelescopeSelectionCaret = { link = "@chiefdog.declaration" },
    TelescopeTitle = { link = "@chiefdog.declaration" },
    TelescopeResultsTitle = { link = "@chiefdog.declaration" },
    --- fzf-lua
    FzfLuaBorder = { fg = "#2b3d40" },
    --- mini.nvim
    -- MiniPickMatchCurrent = { fg = "#f09942" },
    --- Neogit
    NeogitPopupActionDisabled = { fg = darker_fg },
    NeogitPopupActionKey = { fg = ansi.magenta },
    NeogitPopupOptionDisabled = { fg = darker_fg },
    NeogitPopupOptionKey = { fg = ansi.blue },
    NeogitPopupSwitchDisabled = { fg = darker_fg },
    NeogitPopupSwitchEnabled = { fg = ansi.cyan },
    NeogitPopupSwitchKey = { fg = ansi.magenta },
    --- Fugitive
    diffAdded = { link = "DiffAdd" },
    diffRemoved = { link = "DiffDelete" },
    --- Startify
    StartifyBracket = { fg = darker_fg },
    StartifyFile = { fg = ansi.white },
    StartifySection = { fg = ansi.green },
    StartifySlash = { fg = "#4e6e75" },
    StartifyPath = { fg = "#4e6e75" },
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
    --- vim-matchup
    MatchupVirtualText = { fg = ansi.yellow },
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
    --- Hop
    HopNextKey = { fg = ansi.brightyellow },
    HopNextKey1 = { fg = ansi.cyan },
    HopNextKey2 = { fg = "#297567" },
    HopUnmatched = { fg = "#3d3d3d" },
    --- Lightspeed
    LightspeedGreyWash = { fg = "#3d3d3d" },
    --- checkhealth
    healthSuccess = { fg = ansi.green, bg = bg },
    --- cmp
    CmpItemMenuDefault = { fg = ansi.magenta },
    --- nvim-ts-rainbow
    rainbowcol1 = { fg = ansi.yellow },
    rainbowcol2 = { fg = ansi.magenta },
    rainbowcol3 = { fg = ansi.blue },
    rainbowcol4 = { fg = ansi.green },
    rainbowcol5 = { fg = ansi.brightyellow },
    rainbowcol6 = { fg = ansi.red },
    rainbowcol7 = { fg = ansi.cyan },
    --- Iswap
    ISwapSnipe = { bg = ansi.yellow, fg = bg },
    ISwapGrey = { fg = "#3d3d3d" },
    --- vim-dadbod-ui
    dbui_help = { fg = dim_comment },
    dbui_connection_source = { fg = dim_comment },
    --- nvim-dap-virtual-text
    NvimDapVirtualText = { bg = "#1d292b", fg = ansi.cyan },
    --- Noice
    NoiceCmdlineIcon = { link = "@chiefdog.darkGreen" },
    NoiceCmdlinePopupBorder = { link = "@chiefdog.darkGreen" },
    NoiceConfirmBorder = { link = "@chiefdog.darkGreen" },
    NoiceCmdlinePopupBorderCmdline = { link = "@chiefdog.darkGreen" },
    NoiceCmdlineIconCmdline = { link = "@chiefdog.darkGreen" },
    NoiceCmdlinePopupBorderFilter = { link = "@chiefdog.darkGreen" },
    NoiceCmdlineIconFilter = { link = "@chiefdog.darkGreen" },
    NoiceCmdlinePopupBorderLua = { link = "@chiefdog.darkGreen" },
    NoiceCmdlineIconLua = { link = "@chiefdog.darkGreen" },
    NoiceCmdlinePopupBorderSearch = { link = "@chiefdog.yellow" },
    NoiceCmdlineIconSearch = { link = "@chiefdog.yellow" },
    -- Languages
    --- asm
    asmDirective = { fg = dim_comment },
    nasmLabel = { link = "@chiefdog.declaration" },
  }
else
  -- terminal colors
  vim.g.terminal_color_0 = "#000000"
  vim.g.terminal_color_1 = "#aa3731"
  vim.g.terminal_color_2 = "#448c27"
  vim.g.terminal_color_3 = "#cb9000"
  vim.g.terminal_color_4 = "#325cc0"
  vim.g.terminal_color_5 = "#7a3e9d"
  vim.g.terminal_color_6 = "#0083b2"
  vim.g.terminal_color_7 = "#f7f7f7"
  vim.g.terminal_color_8 = "#777777"
  vim.g.terminal_color_9 = "#f05050"
  vim.g.terminal_color_10 = "#60cb00"
  vim.g.terminal_color_11 = "#ffbc5d"
  vim.g.terminal_color_12 = "#007acc"
  vim.g.terminal_color_13 = "#e64ce6"
  vim.g.terminal_color_14 = "#00aacb"
  vim.g.terminal_color_15 = "#f7f7f7"

  -- colors
  local bg = "#f7f7f7"
  local fg = "#222222"
  local muted_fg = "#666666"
  local def_fg = "#325cc0"
  local const_fg = "#448c27"
  local comment = "#aa3731"
  local active = "#ffbc5d"
  local active_blue = "#007acc"
  local string_fg = "#448c27"
  local darker_fg = "#7d7d7d"
  local diffadd = const_fg
  local diffdelete = muted_fg
  local diffchange = comment
  local statusline = "#c9c9c9"
  local dim_comment = "#696969"
  local mistake = {
    fg = "#c33c33",
    bg = "#f8b28f",
  }
  local ansi = {
    black = "#000000",
    blue = "#325cc0",
    brightyellow = "#ffbc5d",
    cyan = "#0083b2",
    green = "#448c27",
    magenta = "#7a3e9d",
    red = "#aa3731",
    white = "#f7f7f7",
    yellow = "#cb9000",
  }
  local error = "#d13e23"
  local warn = "#BC7500"
  local hint = ansi.blue
  local info = "#278C00"
  local comment_fg = comment
  local pmenu_bg = "#e7e7e7"
  local float_bg = pmenu_bg
  local floatborder = {
    bg = float_bg,
    fg = float_bg,
  }
  theme = {
    -- Theme colors
    ["@chiefdog.base"] = { fg = fg },
    ["@chiefdog.variable"] = { fg = const_fg },
    ["@chiefdog.marker"] = { fg = comment_fg },
    ["@chiefdog.declaration"] = { fg = def_fg },
    ["@chiefdog.muted"] = { fg = muted_fg },
    ["@chiefdog.positive"] = { fg = const_fg, bg = "#e6f2e3" },
    ["@chiefdog.positive.foreground"] = { fg = const_fg },
    ["@chiefdog.positive.background"] = { bg = "#e6f2e3" },
    ["@chiefdog.negative"] = { fg = muted_fg, bg = "#e8e8e8" },
    ["@chiefdog.negative.foreground"] = { fg = muted_fg },
    ["@chiefdog.negative.background"] = { fg = "#e8e8e8" },
    ["@chiefdog.highlight"] = { fg = comment_fg, bg = "#f9e6e5" },
    ["@chiefdog.highlight.foreground"] = { fg = comment_fg },
    ["@chiefdog.highlight.background"] = { bg = "#f9e6e5" },
    -- Base
    ["@function"] = { link = "@chiefdog.base" },
    ["@variable"] = { link = "@chiefdog.base" },
    ["@property"] = { link = "@chiefdog.base" },
    ["@type"] = { link = "@chiefdog.base" },
    Special = { link = "@chiefdog.base" },
    -- Variables
    ["@string"] = { link = "@chiefdog.variable" },
    ["@character"] = { link = "@chiefdog.variable" },
    ["@number"] = { link = "@chiefdog.variable" },
    ["@boolean"] = { link = "@chiefdog.variable" },
    -- Muted
    ["@keyword"] = { link = "@chiefdog.muted" },
    ["@punctuation.delimeter"] = { link = "@chiefdog.muted" },
    ["@punctuation.bracket"] = { link = "@chiefdog.muted" },
    ["@punctuation.special"] = { link = "@chiefdog.muted" },
    Operator = { link = "@chiefdog.muted" },
    -- Markers
    ["@keyword.return"] = { link = "@chiefdog.return" },
    Comment = { link = "@chiefdog.marker" },
    -- UI
    --- Search
    Search = { link = "@chiefdog.highlight.background" },
    CurSearch = { link = "@chiefdog.highlight" },
    Visual = { link = "Search" },
    IncSearch = { link = "Search" },
    -- New Code Ended
    Function = { link = "@chiefdog.declaration" },
    ColorColumn = { bg = "#E2EEEE" },
    Conceal = { fg = "#b0b0b0" },
    Cursor = { bg = "#007acc", fg = "#bfdbfe" },
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = "#E2EEEE" },
    CursorLine = { bg = "#E2EEEE" },
    Directory = { fg = ansi.blue },
    DiffAdd = { link = "@chiefdog.positive.background" },
    DiffDelete = { link = "@chiefdog.negative" },
    DiffChange = { link = "@chiefdog.positive.background" },
    DiffText = { link = "@chiefdog.highlight" },
    EndOfBuffer = { fg = "#b6b6b6" },
    -- TermCursor   { }, -- cursor in a focused terminal
    TermCursorNC = { fg = bg, bg = fg },
    ErrorMsg = { link = "@chiefdog.highlight.foreground" },
    VertSplit = { fg = "#abbdc0" },
    Folded = { bg = "#dddddd", fg = "#7d7d7d" },
    FoldColumn = { bg = bg, fg = "#4d4d4d" },
    SignColumn = {},
    -- Substitute   { }, -- |:substitute| replacement text highlighting
    LineNr = { fg = "#7d7c7c" },
    CursorLineNr = { fg = ansi.blue, bold = 1 },
    MatchParen = { underline = 1, sp = active },
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    MoreMsg = { fg = ansi.green, bold = 1 },
    NonText = { fg = "#696969" },
    Normal = { bg = bg, fg = fg },
    NormalFloat = { bg = float_bg },
    -- NormalNC     { }, -- normal text in non-current windows
    FloatBorder = floatborder,
    Pmenu = { bg = pmenu_bg },
    PmenuSel = { bg = "#c7c7c7" },
    PmenuSbar = { bg = "#777777" },
    PmenuThumb = { bg = "#333333" },
    Question = { fg = ansi.green },
    QuickFixLine = { bg = "#E2EEEE" },
    SpellBad = { undercurl = 1, sp = ansi.red },
    SpellCap = { undercurl = 1, sp = ansi.blue },
    SpellLocal = { undercurl = 1, sp = ansi.cyan },
    SpellRare = { undercurl = 1, sp = ansi.magenta },
    StatusLine = { bg = statusline, fg = fg },
    StatusLineNC = { bg = statusline, fg = "#9f9f9f" },
    TabLine = { bg = statusline, fg = "#7d7d7d" },
    TabLineFill = { bg = statusline },
    TabLineSel = { bg = statusline, fg = ansi.blue },
    Title = { fg = def_fg },
    VisualNOS = { bg = "#bfdbfe" },
    WarningMsg = { fg = "#e1ad4c" },
    WildMenu = { bg = "#999999" },
    WinBar = { bg = bg, fg = ansi.black, bold = true },
    WinBarNC = { bg = bg, fg = "#7d7d7d" },

    --- SYNTAX I: TS groups link to these

    -- TODO better color than diffchange, try reddish
    -- SpecialChar = { fg = diffchange }, --  special character in a constant
    -- Tag            { }, --    you can use CTRL-] on this
    -- Delimiter      { },
    SpecialComment = { bg = "#FFDEAA", fg = ansi.blue },
    debugPc = { bg = "#C7C7EE" },
    debugBreakpoint = { bg = "#F8B28F" },
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

    Todo = { bg = "#FFDEAA", fg = ansi.blue },

    --- Diagnostic
    LspReferenceText = { bg = "#dadada" },
    LspReferenceRdad = { bg = "#dadada" },
    LspReferenceWrite = { bg = "#dadada", underline = 1, sp = active_blue },
    LspCodeLens = { fg = "#999999" },
    LspCodeLensSeparator = { fg = "#999999" },

    --- Diagnostic
    DiagnosticError = { link = "@chiefdog.highlight.foreground" },
    DiagnosticWarn = { fg = warn },
    DiagnosticHint = { fg = hint },
    DiagnosticInfo = { fg = info },
    DiagnosticVirtualTextError = { bg = "#F8B28F", fg = "#411414" },
    DiagnosticVirtualTextWarn = { bg = "#fff987", fg = fg },
    DiagnosticVirtualTextHint = { fg = "#0F171D", bg = "#C3D0DA" },
    DiagnosticVirtualTextInfo = { bg = "#ADFFB7", fg = "#042F09" },

    ["@error"] = { link = "@chiefdog.highlight.foreground" },
    ["@tag.delimiter"] = { fg = muted_fg },
    ["@text.note"] = { bg = "#dddddd", fg = ansi.blue },
    ["@text.warning"] = { bg = "#FFDEAA", fg = ansi.blue },

    --- Gitsigns
    GitSignsAdd = { fg = "#6abf40" },
    GitSignsChange = { fg = diffchange },
    GitSignsDelete = { fg = diffdelete },
    --- Telescope
    TelescopeBorder = { fg = "#abbdc0" },
    TelescopeMatching = { link = "Search" },
    TelescopeSelection = { link = "Search" },
    TelescopeMultiSelection = { link = "Search" },
    TelescopePreviewMatch = { link = "Search" },
    TelescopePreviewLine = { link = "Search" },
    TelescopePromptPrefix = { fg = ansi.blue },
    TelescopeSelectionCaret = { link = "@chiefdog.declaration" },
    TelescopeTitle = { link = "@chiefdog.declaration" },
    TelescopeResultsTitle = { link = "@chiefdog.declaration" },
    --- fzf-lua
    FzfLuaBorder = { fg = "#abbdc0" },
    --- Neogit
    NeogitPopupActionDisabled = { fg = darker_fg },
    NeogitPopupActionKey = { fg = ansi.magenta },
    NeogitPopupOptionDisabled = { fg = darker_fg },
    NeogitPopupOptionKey = { fg = ansi.blue },
    NeogitPopupSwitchDisabled = { fg = darker_fg },
    NeogitPopupSwitchEnabled = { fg = ansi.cyan },
    NeogitPopupSwitchKey = { fg = ansi.magenta },
    --- Fugitive
    diffAdded = { link = "DiffAdd" },
    diffRemoved = { link = "DiffDelete" },
    --- Startify
    StartifyBracket = { fg = darker_fg },
    StartifyFile = { fg = ansi.black },
    StartifySection = { fg = ansi.green },
    StartifySlash = { fg = "#4e6e75" },
    StartifyPath = { fg = "#4e6e75" },
    --- Statusline
    StatuslineAdd = { fg = diffadd, bg = statusline },
    StatuslineErr = { fg = "#8E1410", bg = statusline },
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
    --- vim-matchup
    MatchupVirtualText = { fg = ansi.yellow },
    --- For `highlight link`
    ["@chiefdog.black"] = { fg = ansi.black },
    ["@chiefdog.blue"] = { fg = ansi.blue },
    ["@chiefdog.brightyellow"] = { fg = ansi.brightyellow },
    ["@chiefdog.cyan"] = { fg = ansi.cyan },
    ["@chiefdog.green"] = { fg = ansi.green },
    ["@chiefdog.brightGreen"] = { fg = "#60cb00" },
    ["@chiefdog.magenta"] = { fg = ansi.magenta },
    ["@chiefdog.red"] = { fg = ansi.red },
    ["@chiefdog.white"] = { fg = ansi.white },
    ["@chiefdog.yellow"] = { fg = ansi.yellow },
    --- Hop
    HopNextKey = { fg = ansi.yellow },
    HopNextKey1 = { fg = ansi.blue },
    HopNextKey2 = { fg = "#17A2D6" },
    HopUnmatched = { fg = "#bfbfbf" },
    --- Lightspeed
    LightspeedGreyWash = { fg = "#bfbfbf" },
    --- checkhealth
    healthSuccess = { fg = ansi.green, bg = bg },
    --- cmp
    CmpItemMenuDefault = { fg = ansi.magenta },
    --- nvim-ts-rainbow
    rainbowcol1 = { fg = ansi.yellow },
    rainbowcol2 = { fg = ansi.magenta },
    rainbowcol3 = { fg = ansi.blue },
    rainbowcol4 = { fg = ansi.green },
    rainbowcol5 = { fg = ansi.brightyellow },
    rainbowcol6 = { fg = ansi.red },
    rainbowcol7 = { fg = ansi.cyan },
    --- Iswap
    ISwapSnipe = { bg = ansi.yellow, fg = bg },
    ISwapGrey = { fg = "#bfbfbf" },
    --- vim-dadbod-ui
    dbui_help = { fg = dim_comment },
    dbui_connection_source = { fg = dim_comment },
    --- nvim-dap-virtual-text
    NvimDapVirtualText = { bg = "#78D2C9", fg = fg },
    --- Noice
    NoiceCmdlineIcon = { link = "@chiefdog.brightGreen" },
    NoiceCmdlinePopupBorder = { link = "@chiefdog.brightGreen" },
    NoiceConfirmBorder = { link = "@chiefdog.brightGreen" },
    NoiceCmdlinePopupBorderCmdline = { link = "@chiefdog.brightGreen" },
    NoiceCmdlineIconCmdline = { link = "@chiefdog.brightGreen" },
    NoiceCmdlinePopupBorderFilter = { link = "@chiefdog.brightGreen" },
    NoiceCmdlineIconFilter = { link = "@chiefdog.brightGreen" },
    NoiceCmdlinePopupBorderLua = { link = "@chiefdog.brightGreen" },
    NoiceCmdlineIconLua = { link = "@chiefdog.brightGreen" },
    NoiceCmdlinePopupBorderSearch = { link = "@chiefdog.yellow" },
    NoiceCmdlineIconSearch = { link = "@chiefdog.yellow" },
    -- Languages
    --- asm
    asmDirective = { fg = dim_comment },
    nasmLabel = { link = "@chiefdog.declaration" },
  }
end

for group, hl in pairs(theme) do
  vim.api.nvim_set_hl(0, group, hl)
end
