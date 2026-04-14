-- stylua: ignore start
vim.g.mapleader = " " -- Use `<Space>` as <Leader> key

-- General
vim.o.mouse      = "a"   -- Enable mouse
vim.o.undofile   = true  -- Enable persistent undo
vim.o.swapfile   = false -- Disable swapfile
vim.o.timeoutlen = 500   -- Wait less time for a mapped sequence to complete
vim.opt.confirm  = true  -- Raise a dialog asking if you wish to save the current file(s)

vim.opt.grepprg = "rg --vimgrep" -- Use rg for the :grep command
vim.o.shada     = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
vim.opt.path:append({ "**" }) -- Add the current and all subdirectories to the search path
vim.opt.wildignore:append({ "**/node_modules/**", "**/.git/**", "**/build/**" }) -- Ignore certain directories

-- UI
vim.o.wrap           = false      -- Don't visually wrap lines (toggle with \w)
vim.o.breakindent    = true       -- Indent wrapped lines to match line start
vim.o.breakindentopt = "list:-1"  -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn    = "+1"       -- Draw column on the right of maximum width
vim.o.cursorline     = true       -- Enable current line highlighting
vim.o.linebreak      = true       -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.number         = true       -- Show line numbers
vim.o.relativenumber = true       -- Show relative line numbers
vim.o.pumheight      = 10         -- Make popup menu smaller
vim.o.pummaxwidth    = 100        -- Make popup menu not too wide
vim.o.scrolloff      = 100        -- Keep cursor centered
vim.o.signcolumn     = "yes"      -- Always show signcolumn
vim.o.splitbelow     = true       -- Horizontal splits will be below
vim.o.splitright     = true       -- Vertical splits will be to the right
vim.o.splitkeep      = "screen"   -- Reduce scroll during window split
vim.o.pumborder      = "single"   -- Use border in popup menu
vim.o.winborder      = "single"   -- Use border in floating windows
vim.o.list           = true       -- Show helpful text indicators

vim.o.listchars      = "tab:  ,trail:·,nbsp:␣" -- Strings to use in 'list' mode

-- Editing
vim.o.autoindent    = true    -- Use auto indent
vim.o.expandtab     = true    -- Convert tabs to spaces
vim.o.shiftwidth    = 2       -- Use this number of spaces for indentation
vim.o.tabstop       = 2       -- Show tab as this number of spaces
vim.o.formatoptions = "rqnl1j"-- Improve comment editing
vim.o.ignorecase    = true    -- Ignore case during search
vim.o.incsearch     = true    -- Show search matches while typing
vim.o.infercase     = true    -- Infer case in built-in completion
vim.o.smartcase     = true    -- Respect case if search pattern has upper case
vim.o.smartindent   = true    -- Make indenting smart
vim.o.spelloptions  = "camel" -- Treat camelCase word parts as separate words
vim.o.virtualedit   = "block" -- Allow going past end of line in blockwise mode
vim.o.inccommand    = "split" -- Shows the effects of :substitute command

-- Built-in completion
vim.o.complete        = ".,w,b,kspell"                  -- Use less sources
vim.o.completeopt     = "menuone,noselect,fuzzy,nosort" -- Use custom behavior
vim.opt.wildmode      = "noselect:lastused,full"        -- Use custom behaviour for cmdline-completion
vim.o.completetimeout = 100                             -- Limit sources delay

-- Diagnostics
local diagnostic_opts = {
  severity_sort = true,
  underline = { severity = { min = "HINT", max = "ERROR" } },
  virtual_lines = false,
  virtual_text = { current_line = true },
  update_in_insert = false,
  jump = { float = true },
}

Config.later(function() vim.o.clipboard = "unnamedplus" end)
Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
-- stylua: ignore end
