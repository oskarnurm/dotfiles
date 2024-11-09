vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Better visual block mode
vim.opt.virtualedit = 'block'

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.colorcolumn = '80'
vim.diagnostic.config {
  float = { border = 'rounded' }, -- add border to diagnostic popups
}
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Disable swap files as they become very annoying when editing symlinks
vim.opt.swapfile = false

-- Backup creates a copy before changes are made that can be recovered.
-- Unecessary if undo-tree enabled
vim.opt.backup = false

-- Enables presistent undo that works well with undo-tree plugin
vim.opt.undofile = true

-- With presistent undo enabled it makes sense to specify a custom directory to avoid cluttering working directories
vim.opt.undodir = os.getenv 'HOME' .. '/.neovim/undodir'

-- Confirm to save changes before exiting modified buffer
vim.opt.confirm = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Number of spaces tabs count for
vim.opt.tabstop = 2

-- Size of an indent
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

vim.opt.termguicolors = true -- True color support

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
