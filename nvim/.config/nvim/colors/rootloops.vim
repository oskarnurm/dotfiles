" Store the following config under ~/.config/nvim/colors/root-loops.vim
" then load it into neovim via ':colorscheme root-loops' or by declaring
" it as your colorscheme in your neovim config.

" root-loops.vim -- Root Loops Vim Color Scheme.
" Webpage:          https://rootloops.sh?sugar=5&colors=10&sogginess=0&flavor=1&fruit=1&milk=3
" Description:      A neovim color scheme for cereal lovers

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "root loops"

if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
    hi Normal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi NonText ctermfg=0 guifg=#f1f1f1
    hi Comment ctermfg=8 cterm=italic guifg=#ababab gui=italic
    hi Constant ctermfg=3 guifg=#926200
    hi Error ctermfg=1 guifg=#ca0043
    hi Identifier ctermfg=9 guifg=#f30052
    hi Function ctermfg=4 guifg=#006acf
    hi Special ctermfg=13 guifg=#c301fb
    hi Delimiter ctermfg=15 guifg=#3a3a3a
    hi Statement ctermfg=5 guifg=#a200d1
    hi String ctermfg=2 guifg=#407f00
    hi Operator ctermfg=6 guifg=#007d7d
    hi Boolean ctermfg=3 guifg=#926200
    hi Label ctermfg=14 guifg=#009797
    hi Keyword ctermfg=5 guifg=#a200d1
    hi Exception ctermfg=5 guifg=#a200d1
    hi Conditional ctermfg=5 guifg=#a200d1
    hi PreProc ctermfg=13 guifg=#c301fb
    hi Include ctermfg=5 guifg=#a200d1
    hi Macro ctermfg=5 guifg=#a200d1
    hi StorageClass ctermfg=11 guifg=#b07700
    hi Structure ctermfg=11 guifg=#b07700
    hi Todo ctermbg=12 ctermfg=0 cterm=bold guibg=#0081f8 guifg=#f1f1f1 gui=bold
    hi Type ctermfg=11 guifg=#b07700
    hi Underlined cterm=underline gui=underline
    hi Bold cterm=bold gui=bold
    hi Italic cterm=italic gui=italic
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
    hi StatusLine ctermbg=0 ctermfg=15 cterm=NONE guibg=#e2e2e2 guifg=#3a3a3a gui=NONE
    hi StatusLineNC ctermbg=0 ctermfg=15 cterm=NONE guibg=#f1f1f1 guifg=#222222 gui=NONE
    hi VertSplit ctermfg=8 guifg=#ababab
    hi TabLine ctermbg=0 ctermfg=7 guibg=#e2e2e2 guifg=#6a6a6a
    hi TabLineFill ctermbg=NONE ctermfg=0 guibg=NONE guifg=#e2e2e2
    hi TabLineSel ctermbg=11 ctermfg=0 guibg=#b07700 guifg=#e2e2e2
    hi Title ctermfg=4 cterm=bold guifg=#006acf gui=bold
    hi CursorLine ctermbg=0 ctermfg=NONE guibg=#e2e2e2 guifg=NONE
    hi Cursor ctermbg=15 ctermfg=0 guibg=#3a3a3a guifg=#f1f1f1
    hi CursorColumn ctermbg=0 guibg=#e2e2e2
    hi LineNr ctermfg=8 guifg=#ababab
    hi CursorLineNr ctermfg=6 guifg=#007d7d
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    hi Visual ctermbg=8 ctermfg=15 cterm=bold guibg=#ababab guifg=#3a3a3a gui=bold
    hi VisualNOS ctermbg=8 ctermfg=15 cterm=bold guibg=#ababab guifg=#3a3a3a gui=bold
    hi Pmenu ctermbg=0 ctermfg=15 guibg=#e2e2e2 guifg=#3a3a3a
    hi PmenuSbar ctermbg=8 ctermfg=7 guibg=#ababab guifg=#6a6a6a
    hi PmenuSel ctermbg=8 ctermfg=15 cterm=bold guibg=#ababab guifg=#3a3a3a gui=bold
    hi PmenuThumb ctermbg=7 ctermfg=NONE guibg=#6a6a6a guifg=NONE
    hi FoldColumn ctermfg=7 guifg=#6a6a6a
    hi Folded ctermfg=12 guifg=#0081f8
    hi WildMenu ctermbg=0 ctermfg=15 cterm=NONE guibg=#e2e2e2 guifg=#3a3a3a gui=NONE
    hi SpecialKey ctermfg=0 guifg=#e2e2e2
    hi IncSearch ctermbg=1 ctermfg=0 guibg=#ca0043 guifg=#f1f1f1
    hi CurSearch ctermbg=3 ctermfg=0 guibg=#926200 guifg=#f1f1f1
    hi Search ctermbg=11 ctermfg=0 guibg=#b07700 guifg=#f1f1f1
    hi Directory ctermfg=4 guifg=#006acf
    hi MatchParen ctermbg=0 ctermfg=3 cterm=bold guibg=#e2e2e2 guifg=#926200 gui=bold
    hi SpellBad cterm=undercurl gui=undercurl guisp=#f30052
    hi SpellCap cterm=undercurl gui=undercurl guisp=#b07700
    hi SpellLocal cterm=undercurl gui=undercurl guisp=#0081f8
    hi SpellRare cterm=undercurl gui=undercurl guisp=#4f9a00
    hi ColorColumn ctermbg=8 guibg=#ababab
    hi SignColumn ctermfg=7 guifg=#6a6a6a
    hi ModeMsg ctermbg=15 ctermfg=0 cterm=bold guibg=#222222 guifg=#e2e2e2 gui=bold
    hi MoreMsg ctermfg=4 guifg=#006acf
    hi Question ctermfg=4 guifg=#006acf
    hi QuickFixLine ctermbg=0 ctermfg=14 guibg=#e2e2e2 guifg=#009797
    hi Conceal ctermfg=8 guifg=#ababab
    hi ToolbarLine ctermbg=0 ctermfg=15 guibg=#e2e2e2 guifg=#222222
    hi ToolbarButton ctermbg=8 ctermfg=15 guibg=#ababab guifg=#222222
    hi debugPC ctermfg=7 guifg=#6a6a6a
    hi debugBreakpoint ctermfg=8 guifg=#ababab
    hi ErrorMsg ctermfg=1 cterm=bold,italic guifg=#ca0043 gui=bold,italic
    hi WarningMsg ctermfg=11 guifg=#b07700
    hi DiffAdd ctermbg=10 ctermfg=0 guibg=#4f9a00 guifg=#f1f1f1
    hi DiffChange ctermbg=12 ctermfg=0 guibg=#0081f8 guifg=#f1f1f1
    hi DiffDelete ctermbg=9 ctermfg=0 guibg=#f30052 guifg=#f1f1f1
    hi DiffText ctermbg=14 ctermfg=0 guibg=#009797 guifg=#f1f1f1
    hi diffAdded ctermfg=10 guifg=#4f9a00
    hi diffRemoved ctermfg=9 guifg=#f30052
    hi diffChanged ctermfg=12 guifg=#0081f8
    hi diffOldFile ctermfg=11 guifg=#b07700
    hi diffNewFile ctermfg=13 guifg=#c301fb
    hi diffFile ctermfg=12 guifg=#0081f8
    hi diffLine ctermfg=7 guifg=#6a6a6a
    hi diffIndexLine ctermfg=14 guifg=#009797
    hi healthError ctermfg=1 guifg=#ca0043
    hi healthSuccess ctermfg=2 guifg=#407f00
    hi healthWarning ctermfg=3 guifg=#926200
    hi NormalFloat ctermbg=0 ctermfg=15 guibg=#f1f1f1 guifg=#3a3a3a
    hi FloatBorder ctermbg=0 ctermfg=7 guibg=#f1f1f1 guifg=#6a6a6a
    hi FloatShadow ctermbg=0 ctermfg=15 guibg=#e2e2e2 guifg=#3a3a3a
    hi @variable ctermfg=15 guifg=#3a3a3a
    hi @variable.builtin ctermfg=1 guifg=#ca0043
    hi @variable.parameter ctermfg=1 guifg=#ca0043
    hi @variable.member ctermfg=1 guifg=#ca0043
    hi @constant.builtin ctermfg=5 guifg=#a200d1
    hi @string.regexp ctermfg=1 guifg=#ca0043
    hi @string.escape ctermfg=6 guifg=#007d7d
    hi @string.special.url ctermfg=4 cterm=underline guifg=#006acf gui=underline
    hi @string.special.symbol ctermfg=13 guifg=#c301fb
    hi @type.builtin ctermfg=3 guifg=#926200
    hi @property ctermfg=1 guifg=#ca0043
    hi @function.builtin ctermfg=5 guifg=#a200d1
    hi @constructor ctermfg=11 guifg=#b07700
    hi @keyword.function ctermfg=5 guifg=#a200d1
    hi @keyword.return ctermfg=5 guifg=#a200d1
    hi @keyword.export ctermfg=12 guifg=#0081f8
    hi @punctuation.bracket ctermfg=15 guifg=#3a3a3a
    hi @comment.error ctermbg=9 ctermfg=0 guibg=#f30052 guifg=#f1f1f1
    hi @comment.warning ctermbg=11 ctermfg=0 guibg=#b07700 guifg=#f1f1f1
    hi @comment.todo ctermbg=12 ctermfg=0 guibg=#0081f8 guifg=#f1f1f1
    hi @comment.note ctermbg=14 ctermfg=0 guibg=#009797 guifg=#f1f1f1
    hi @markup ctermfg=15 guifg=#3a3a3a
    hi @markup.strong ctermfg=15 cterm=bold guifg=#3a3a3a gui=bold
    hi @markup.italic ctermfg=15 cterm=italic guifg=#3a3a3a gui=italic
    hi @markup.strikethrough ctermfg=15 cterm=strikethrough guifg=#3a3a3a gui=strikethrough
    hi @markup.heading ctermfg=4 cterm=bold guifg=#006acf gui=bold
    hi @markup.quote ctermfg=6 guifg=#007d7d
    hi @markup.math ctermfg=4 guifg=#006acf
    hi @markup.link.url ctermfg=5 cterm=underline guifg=#a200d1 gui=underline
    hi @markup.raw ctermfg=14 guifg=#009797
    hi @markup.list.checked ctermfg=2 guifg=#407f00
    hi @markup.list.unchecked ctermfg=7 guifg=#6a6a6a
    hi @tag ctermfg=5 guifg=#a200d1
    hi @tag.builtin ctermfg=6 guifg=#007d7d
    hi @tag.attribute ctermfg=4 guifg=#006acf
    hi @tag.delimiter ctermfg=15 guifg=#3a3a3a

elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
    set t_Co=16
    hi Normal ctermbg=NONE ctermfg=NONE
    hi NonText ctermfg=0
    hi Comment ctermfg=8 cterm=italic
    hi Constant ctermfg=3
    hi Error ctermfg=1
    hi Identifier ctermfg=9
    hi Function ctermfg=4
    hi Special ctermfg=13
    hi Delimiter ctermfg=15
    hi Statement ctermfg=5
    hi String ctermfg=2
    hi Operator ctermfg=6
    hi Boolean ctermfg=3
    hi Label ctermfg=14
    hi Keyword ctermfg=5
    hi Exception ctermfg=5
    hi Conditional ctermfg=5
    hi PreProc ctermfg=13
    hi Include ctermfg=5
    hi Macro ctermfg=5
    hi StorageClass ctermfg=11
    hi Structure ctermfg=11
    hi Todo ctermbg=12 ctermfg=0 cterm=bold
    hi Type ctermfg=11
    hi Underlined cterm=underline
    hi Bold cterm=bold
    hi Italic cterm=italic
    hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE
    hi StatusLine ctermbg=0 ctermfg=15 cterm=NONE
    hi StatusLineNC ctermbg=0 ctermfg=15 cterm=NONE
    hi VertSplit ctermfg=8
    hi TabLine ctermbg=0 ctermfg=7
    hi TabLineFill ctermbg=NONE ctermfg=0
    hi TabLineSel ctermbg=11 ctermfg=0
    hi Title ctermfg=4 cterm=bold
    hi CursorLine ctermbg=0 ctermfg=NONE
    hi Cursor ctermbg=15 ctermfg=0
    hi CursorColumn ctermbg=0
    hi LineNr ctermfg=8
    hi CursorLineNr ctermfg=6
    hi helpLeadBlank ctermbg=NONE ctermfg=NONE
    hi helpNormal ctermbg=NONE ctermfg=NONE
    hi Visual ctermbg=8 ctermfg=15 cterm=bold
    hi VisualNOS ctermbg=8 ctermfg=15 cterm=bold
    hi Pmenu ctermbg=0 ctermfg=15
    hi PmenuSbar ctermbg=8 ctermfg=7
    hi PmenuSel ctermbg=8 ctermfg=15 cterm=bold
    hi PmenuThumb ctermbg=7 ctermfg=NONE
    hi FoldColumn ctermfg=7
    hi Folded ctermfg=12
    hi WildMenu ctermbg=0 ctermfg=15 cterm=NONE
    hi SpecialKey ctermfg=0
    hi IncSearch ctermbg=1 ctermfg=0
    hi CurSearch ctermbg=3 ctermfg=0
    hi Search ctermbg=11 ctermfg=0
    hi Directory ctermfg=4
    hi MatchParen ctermbg=0 ctermfg=3 cterm=bold
    hi SpellBad cterm=undercurl
    hi SpellCap cterm=undercurl
    hi SpellLocal cterm=undercurl
    hi SpellRare cterm=undercurl
    hi ColorColumn ctermbg=8
    hi SignColumn ctermfg=7
    hi ModeMsg ctermbg=15 ctermfg=0 cterm=bold
    hi MoreMsg ctermfg=4
    hi Question ctermfg=4
    hi QuickFixLine ctermbg=0 ctermfg=14
    hi Conceal ctermfg=8
    hi ToolbarLine ctermbg=0 ctermfg=15
    hi ToolbarButton ctermbg=8 ctermfg=15
    hi debugPC ctermfg=7
    hi debugBreakpoint ctermfg=8
    hi ErrorMsg ctermfg=1 cterm=bold,italic
    hi WarningMsg ctermfg=11
    hi DiffAdd ctermbg=10 ctermfg=0
    hi DiffChange ctermbg=12 ctermfg=0
    hi DiffDelete ctermbg=9 ctermfg=0
    hi DiffText ctermbg=14 ctermfg=0
    hi diffAdded ctermfg=10
    hi diffRemoved ctermfg=9
    hi diffChanged ctermfg=12
    hi diffOldFile ctermfg=11
    hi diffNewFile ctermfg=13
    hi diffFile ctermfg=12
    hi diffLine ctermfg=7
    hi diffIndexLine ctermfg=14
    hi healthError ctermfg=1
    hi healthSuccess ctermfg=2
    hi healthWarning ctermfg=3
    hi NormalFloat ctermbg=0 ctermfg=15
    hi FloatBorder ctermbg=0 ctermfg=7
    hi FloatShadow ctermbg=0 ctermfg=15
    hi @variable ctermfg=15
    hi @variable.builtin ctermfg=1
    hi @variable.parameter ctermfg=1
    hi @variable.member ctermfg=1
    hi @constant.builtin ctermfg=5
    hi @string.regexp ctermfg=1
    hi @string.escape ctermfg=6
    hi @string.special.url ctermfg=4 cterm=underline
    hi @string.special.symbol ctermfg=13
    hi @type.builtin ctermfg=3
    hi @property ctermfg=1
    hi @function.builtin ctermfg=5
    hi @constructor ctermfg=11
    hi @keyword.function ctermfg=5
    hi @keyword.return ctermfg=5
    hi @keyword.export ctermfg=12
    hi @punctuation.bracket ctermfg=15
    hi @comment.error ctermbg=9 ctermfg=0
    hi @comment.warning ctermbg=11 ctermfg=0
    hi @comment.todo ctermbg=12 ctermfg=0
    hi @comment.note ctermbg=14 ctermfg=0
    hi @markup ctermfg=15
    hi @markup.strong ctermfg=15 cterm=bold
    hi @markup.italic ctermfg=15 cterm=italic
    hi @markup.strikethrough ctermfg=15 cterm=strikethrough
    hi @markup.heading ctermfg=4 cterm=bold
    hi @markup.quote ctermfg=6
    hi @markup.math ctermfg=4
    hi @markup.link.url ctermfg=5 cterm=underline
    hi @markup.raw ctermfg=14
    hi @markup.list.checked ctermfg=2
    hi @markup.list.unchecked ctermfg=7
    hi @tag ctermfg=5
    hi @tag.builtin ctermfg=6
    hi @tag.attribute ctermfg=4
    hi @tag.delimiter ctermfg=15
endif

hi link EndOfBuffer NonText
hi link SpecialComment Special
hi link Define PreProc
hi link PreCondit PreProc
hi link Number Constant
hi link Float Number
hi link Typedef Type
hi link SpecialChar Special
hi link Debug Special
hi link StatusLineTerm StatusLine
hi link StatusLineTermNC StatusLineNC
hi link WinSeparator VertSplit
hi link WinBar StatusLine
hi link WinBarNC StatusLineNC
hi link lCursor Cursor
hi link CursorIM Cursor
hi link Terminal Normal
hi link @variable.parameter.builtin @variable.parameter
hi link @constant Constant
hi link @constant.macro Macro
hi link @module Structure
hi link @module.builtin Special
hi link @label Label
hi link @string String
hi link @string.special Special
hi link @character Character
hi link @character.special SpecialChar
hi link @boolean Boolean
hi link @number Number
hi link @number.float Float
hi link @type Type
hi link @type.definition Type
hi link @attribute Constant
hi link @attribute.builtin Constant
hi link @function Function
hi link @function.call Function
hi link @function.method Function
hi link @function.method.call Function
hi link @operator Operator
hi link @keyword Keyword
hi link @keyword.coroutine Keyword
hi link @keyword.operator Operator
hi link @keyword.import Include
hi link @keyword.type Keyword
hi link @keyword.modifier Keyword
hi link @keyword.repeat Repeat
hi link @keyword.debug Exception
hi link @keyword.exception Exception
hi link @keyword.conditional Conditional
hi link @keyword.conditional.ternary Operator
hi link @keyword.directive PreProc
hi link @keyword.directive.define Define
hi link @punctuation.delimiter Delimiter
hi link @punctuation.special Special
hi link @comment Comment
hi link @comment.documentation Comment
hi link @markup.underline underline
hi link @markup.link Tag
hi link @markup.link.label Label
hi link @markup.list Special
hi link @diff.plus diffAdded
hi link @diff.minus diffRemoved
hi link @diff.delta diffChanged

if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = [ '#e2e2e2', '#ca0043', '#407f00', '#926200', '#006acf', '#a200d1', '#007d7d', '#6a6a6a', '#ababab', '#f30052', '#4f9a00', '#b07700', '#0081f8', '#c301fb', '#009797', '#222222' ]
endif
