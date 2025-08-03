-- stylua: ignore start

-- Set completion options for Vim's insert mode completion:
-- "menuone"   : Show the completion menu even if there is only one match
-- "noinsert"  : Do not automatically insert text until selection is made
-- "preview"   : Show a preview window with extra information about the selected item
vim.opt.completeopt = "menuone,noinsert,preview"

-- Enable 24-bit RGB color in the terminal for better color support
vim.opt.termguicolors = true

-- Highlight the 80th column as a visual guide for line length limits
vim.opt.colorcolumn = "80"

-- Enable mouse mode, can be useful for resizing splits
vim.o.mouse = 'a'

-- Always show the sign column to prevent text shifting when signs (like errors or git changes) appear
vim.opt.signcolumn = "yes"

-- Bigger signcolumn
vim.cmd [[let &stc = '%s %5l ']]

-- Enable absolute and relative line numbers for line jumps
vim.opt.number = true
vim.opt.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

-- Use spaces instead of literal tab characters
vim.opt.expandtab = true

-- Number of spaces that a “tab” character represents
vim.opt.tabstop = 2

-- Set the number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2

-- Automatically indenting new lines based on context
vim.opt.smartindent = true

-- Don’t wrap long lines; let them scroll horizontally
vim.opt.wrap = false

-- Show invisible characters like tabs and trailing spaces
vim.opt.list = true

-- Define how invisible characters are displayed:
-- tab: display tabs as two spaces
-- trail: show trailing spaces as '·'
-- nbsp: show non-breaking spaces as '␣'
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Preview substitutions live, as you type
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Better visual block edit
vim.opt.virtualedit = "block"

-- Configure diagnostics display:
-- virtual_text = true  : Show diagnostic messages inline as virtual text
-- underline = false    : Disable underlining of problematic text
vim.diagnostic.config { virtual_text = true, underline = false }

-- Use a single-line border for popup windows to improve visual clarity and readability
vim.opt.winborder = "single"

-- Raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Enable persistent undo to save undo history between sessions
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv "HOME" .. "/.neovim/undodir"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Fix paths for Snacks.picker that we otherwise can't see when using a monochrome colorscheme
-- vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#676767" })
-- vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#676767" })
