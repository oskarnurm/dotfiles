vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.completeopt = 'menu,menuone,noinsert,preview'

vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.scrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false

vim.opt.termguicolors = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.opt.virtualedit = 'block'
vim.opt.list = true
vim.diagnostic.config { underline = false, float = { border = 'single' } }
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

vim.opt.statusline = '%F'
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.neovim/undodir'
vim.opt.splitright = true

local border = 'rounded'

-- Set borders for hover and signature help
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
