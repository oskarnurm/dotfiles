vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.spell = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.confirm = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.list = true
vim.opt.winborder = "single"
vim.opt.completeopt = "menuone,noinsert,preview"
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.bg = "light"
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)
vim.diagnostic.config({ virtual_text = true, underline = false })
