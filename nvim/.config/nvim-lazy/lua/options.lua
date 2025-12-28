-- General
vim.g.mapleader = " "

vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.confirm = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%l  "
vim.opt.winborder = "single"
vim.opt.showmode = true
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Editing
vim.opt.wrap = false
vim.opt.spell = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.o.ignorecase = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.o.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part
vim.opt.completeopt = "menuone,noinsert,preview,fuzzy"

-- Disable some default providers
-- see full list: https://github.com/neovim/neovim/tree/master/runtime/plugin
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- setting loaded variable to `1` for these prevents them from loading
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_remote_plugins = 1

vim.opt.path:append(".,**")
vim.opt.wildignore:append({ "*.o", "*.obj", "*/.git/*", "*/node_modules/*", "*/.DS_Store" })
vim.opt.grepformat = "%f:%l:%m"

if vim.fn.executable("rg") == 1 then
    -- Use ripgrep if available
    vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
    vim.opt.grepformat = "%f:%l:%c:%m"
elseif vim.fn.isdirectory(".git") == 1 then
    -- Fallback to git grep if in a repo
    vim.opt.grepprg = "git grep -n"
    vim.opt.grepformat = "%f:%l:%m"
end
