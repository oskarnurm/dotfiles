vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.completeopt = "menuone,noinsert,preview"

vim.opt.signcolumn = "yes"
-- vim.opt.number = true
-- vim.opt.rnu = true
vim.opt.scrolloff = 10

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.wrap = false

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

vim.opt.termguicolors = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.virtualedit = "block"
vim.opt.list = true
vim.diagnostic.config { virtual_text = true, underline = false }
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.opt.winborder = "rounded"

vim.opt.statusline = "%F"
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv "HOME" .. "/.neovim/undodir"
vim.opt.splitright = true

vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = "#676767" })
vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { fg = "#676767" })

-- Highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
