vim.opt.statusline = "%F" -- Show full path in statusline
vim.g.have_nerd_font = true -- Use Nerd Font for enhanced iconography
vim.opt.termguicolors = true -- Enable true color support

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers

vim.opt.mouse = "a" -- Enable mouse support across all modes
vim.opt.clipboard = "unnamedplus" -- Sync Neovim clipboard with system clipboard

vim.opt.breakindent = true -- Maintain indent of wrapped lines
vim.opt.wrap = false -- Disable line wrapping within the window

vim.opt.ignorecase = true -- Search case-insensitively
vim.opt.smartcase = true -- Case-sensitive if search includes uppercase

vim.opt.signcolumn = "yes" -- Always display the sign column
vim.opt.showmode = true -- Don't show the mode, since it's already in the status line

vim.opt.updatetime = 50 -- Time (ms) to wait before triggering events
vim.opt.timeoutlen = 300 -- Time (ms) to wait for a mapped sequence

vim.opt.splitright = true -- Vertical splits open on the right
vim.opt.splitbelow = true -- Horizontal splits open below

vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Whitespace characters

vim.opt.inccommand = "split" -- Show effects of commands in real-time

vim.opt.hlsearch = true -- Highlight all search pattern matches
vim.opt.cursorline = true -- Highlight the line of the cursor
vim.opt.scrolloff = 999 -- Keep cursor vertically centered

vim.opt.swapfile = true -- Enable swap file creation
vim.opt.backup = false -- Disable backup file creation
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir" -- Undo file directory

vim.opt.colorcolumn = "80" -- Highlight the 80th column

vim.opt.smartindent = true -- Automatically indent new lines
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.softtabstop = 4 -- Soft tab stop in spaces
vim.opt.shiftwidth = 4 -- Number of spaces for each indent level
vim.opt.expandtab = true -- Convert tabs to spaces
