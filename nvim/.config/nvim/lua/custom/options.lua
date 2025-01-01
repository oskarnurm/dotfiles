vim.g.mapleader = ' ' -- Global leader key
vim.opt.statusline = '%F' -- Show full path in statusline
vim.opt.signcolumn = 'yes' -- Always display the sign column
vim.opt.path:append '**'
vim.g.maplocalleader = ' ' -- Local leader key
vim.opt.number = true -- Show line numbers.
vim.opt.virtualedit = 'block' -- Allow cursor movement past the end of lines in block mode.
vim.opt.list = true -- Show invisible characters.
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' } -- Configure symbols for tabs, trailing spaces, and non-breaking spaces.
vim.opt.inccommand = 'split' -- Preview substituations live, as you type
vim.opt.cursorline = true -- Highlight the current line
vim.opt.colorcolumn = '80' -- Highlight column 80 as a visual guide for line length.
vim.opt.scrolloff = 10 -- Keep 10 lines of context above and below the cursor.
vim.opt.swapfile = false -- Disable swap files
vim.opt.undofile = true -- Enable persistent undo across sessions.
vim.opt.undodir = os.getenv 'HOME' .. '/.neovim/undodir' -- Set a specific directory for undo files.
vim.opt.expandtab = true -- Convert tabs into spaces.
vim.opt.tabstop = 2 -- Set the width of a tab to 2 spaces.
vim.opt.shiftwidth = 2 -- Set the number of spaces for auto-indents.
vim.opt.smartindent = true -- Automatically indent new lines in a smart way.
vim.opt.termguicolors = true -- Enable true color support for better visuals.
vim.opt.breakindent = true -- Enable break indent
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Overrides ingnorecase if at least one uppercase letter
vim.opt.splitright = true -- New splits to the right
vim.diagnostic.config { underline = false, float = { border = 'single' } } -- Add a rounded border to diagnostic popups.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end) --  Schedule the setting after `UiEnter` because it can increase startup-time.
-- vim.opt.updatetime = 250 -- Updates more often

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set the colorscheme
vim.cmd 'colorscheme quiet'
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#FFFFFF', bold = true }) -- Bold keywords
vim.api.nvim_set_hl(0, 'Comment', { fg = '#888888', italic = true }) -- Darker and italic comments
vim.api.nvim_set_hl(0, 'Constant', { fg = '#999999' }) -- Light gray literals
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' }) -- Transparent background
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#000000' }) -- Darker background for floating windows
vim.api.nvim_set_hl(0, 'Visual', { bg = '#71797E', fg = 'NONE' }) -- Highlight for visual selection
