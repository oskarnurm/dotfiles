vim.loader.enable()

-- Setting options
vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.confirm = true
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "bold"
vim.opt.pumborder = "bold"
vim.opt.pumheight = 15
vim.opt.scrolloff = 999
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.inccommand = "split"
vim.opt.virtualedit = "block"
vim.opt.wildmode = "noselect:lastused,full"
vim.opt.completeopt = "menuone,noinsert,preview,fuzzy"
vim.opt.iskeyword = "@,48-57,_,192-255,-"
vim.opt.grepprg = "rg --vimgrep"

vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.lsp.document_color.enable(true, 0, { style = "virtual" })

local diagnostic_opts = {
  severity_sort = true,
  underline = { severity = { min = "ERROR", max = "ERROR" } },
  virtual_text = { current_line = true, severity = { min = "HINT", max = "ERROR" } },
  virtual_lines = false,
  update_in_insert = false,
  jump = { float = true },
}
vim.schedule(function() vim.diagnostic.config(diagnostic_opts) end)
vim.schedule(function() vim.o.clipboard = "unnamedplus" end)

-- Autocommands
local group = vim.api.nvim_create_augroup("au", { clear = true })
local autocmd = function(event, pattern, callback, args)
  local opts = vim.tbl_extend("force", args or {}, { group = group, pattern = pattern, callback = callback })
  vim.api.nvim_create_autocmd(event, opts)
end

autocmd("TextYankPost", nil, function() vim.hl.on_yank() end)
autocmd("CmdlineChanged", { ":", "/", "?" }, function() vim.fn.wildtrigger() end)
autocmd("FileType", "*", function() vim.opt_local.formatoptions:remove({ "r", "o" }) end)

-- Select first match in commandline
autocmd("CmdlineLeavePre", ":", function()
  local info = vim.fn.cmdcomplete_info()
  if info.matches and #info.matches > 0 and info.selected == -1 then
    local cmd = vim.fn.getcmdline()
    if cmd:match("^find") or cmd:match("^buffer") or cmd:match("^e") then
      vim.fn.setcmdline(cmd:match("^(%w+)%s") .. " " .. info.matches[1])
    end
  end
end)

-- Auto enable language servers
autocmd({ "BufReadPre", "BufNewFile" }, nil, function()
  local server_configs = vim
    .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
    :map(function(file) return vim.fn.fnamemodify(file, ":t:r") end)
    :totable()
  vim.lsp.enable(server_configs)
end, { once = true })

-- Go to last loc when opening a buffer
autocmd("BufReadPost", nil, function(event)
  local exclude = { "gitcommit" }
  local buf = event.buf
  if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then return end
  vim.b[buf].lazyvim_last_loc = true
  local mark = vim.api.nvim_buf_get_mark(buf, '"')
  local lcount = vim.api.nvim_buf_line_count(buf)
  if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
end)

-- Create missing parent directories automatically
autocmd("BufWritePre", nil, function(event)
  if event.match:match("^%w%w+:[\\/][\\/]") then return end
  local file = vim.uv.fs_realpath(event.match) or event.match
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end)

-- Wrap and check for spell in text filetypes
autocmd("FileType", { "text", "plaintex", "typst", "gitcommit", "markdown" }, function()
  vim.opt_local.wrap = true
  vim.opt_local.spell = true
end)

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end
vim.opt.rtp:prepend(lazypath)

-- Add support for the LazyFile event
local Event = require("lazy.core.handler.event")
Event.mappings.LazyFile = { id = "LazyFile", event = { "BufReadPost", "BufNewFile", "BufWritePre" } }
Event.mappings["User LazyFile"] = Event.mappings.LazyFile

-- Configure and install plugins
require("lazy").setup({
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  spec = {
    { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
    { "folke/tokyonight.nvim", opts = {} },
    { "vague-theme/vague.nvim", opts = {} },
    { "p00f/alabaster.nvim" },
    {
      dir = "~/odin/koda.nvim/",
      lazy = false,
      priority = 1000,
      config = function()
        require("koda").setup()
        -- Benchmark with `=MiniMisc.stat_summary(MiniMisc.bench_time(vim.cmd, 1000, 'colorscheme koda'))`
        vim.cmd("colorscheme koda")
      end,
    },
    {
      "mbbill/undotree",
      event = "VeryLazy",
      keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree Toggle" } },
    },
    {
      "stevearc/oil.nvim",
      lazy = false,
      opts = { view_options = { show_hidden = true } },
      keys = { { "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil" } },
    },
    {
      "stevearc/conform.nvim",
      event = "LazyFile",
      opts = {
        format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
        formatters_by_ft = {
          sh = { "shfmt" },
          lua = { "stylua" },
          python = { "ruff_format" },
          html = { "prettierd" },
          javascript = { "prettierd" },
          typescript = { "prettierd" },
          c = { lsp_format = "prefer" },
          java = { lsp_format = "prefer" },
          xml = { "xmlformatter" },
          ["_"] = { "prettierd" },
        },
      },
    },
    {
      "saghen/blink.cmp",
      event = "InsertEnter",
      version = "1.*",
      dependencies = { "rafamadriz/friendly-snippets" },
      opts = {},
    },
    {
      "nvim-treesitter/nvim-treesitter",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      lazy = false,
      config = function()
        local filetypes = {
          "go",
          "python",
          "java",
          "typescript",
          "javascript",
          "bash",
          "c",
          "diff",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
        }
        require("nvim-treesitter").install(filetypes)
        vim.api.nvim_create_autocmd("FileType", {
          pattern = filetypes,
          callback = function()
            vim.treesitter.start()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        vim.g.no_plugin_maps = true
      end,
      config = function()
        local TS = require("nvim-treesitter-textobjects.select")
        vim.keymap.set({ "x", "o" }, "af", function() TS.select_textobject("@function.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "if", function() TS.select_textobject("@function.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ac", function() TS.select_textobject("@class.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ic", function() TS.select_textobject("@class.inner", "textobjects") end)
      end,
    },
    {
      "folke/which-key.nvim",
      event = "LazyFile",
      opts = { preset = "helix", icons = { mappings = false } },
    },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next Hunk" })

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Prev Hunk" })

          -- visual mode
          map(
            "v",
            "ghs",
            function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { desc = "Hunk Stage" }
          )
          map(
            "v",
            "ghr",
            function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { desc = "Hunk Reset" }
          )
          -- normal mode
          map("n", "ghs", gitsigns.stage_hunk, { desc = "Hunk Stage" })
          map("n", "ghr", gitsigns.reset_hunk, { desc = "Hunk Rest" })
          map("n", "ghS", gitsigns.stage_buffer, { desc = "Hunk Stage Buffer" })
          map("n", "ghu", gitsigns.stage_hunk, { desc = "Hunk Undo Stage" })
          map("n", "ghU", gitsigns.reset_buffer, { desc = "Hunk Reset Buffer" })
          map("n", "ghp", gitsigns.preview_hunk, { desc = "Hunk Preview Line" })
          map("n", "ghb", gitsigns.blame_line, { desc = "Hunk Blame Line" })
          map("n", "ghi", gitsigns.diffthis, { desc = "Hunk Diff Index" })
          map("n", "ghc", function() gitsigns.diffthis("@") end, { desc = "Hunk Diff Commit" })
          -- Toggles
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
        end,
      },
    },
    {
      "nvim-mini/mini.nvim",
      event = "LazyFile",
      config = function()
        require("mini.icons").setup()
        require("mini.git").setup()
        require("mini.ai").setup()

        -- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
        -- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
        -- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
        -- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
        -- - `shf`   - *s*urround *h*ighlight current *f*unction call
        -- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
        -- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
        -- - `vaWsa<Space>` - *v*isually select *a*round *W*ORD and *s*urround *a*dd spaces (`<Space>`)
        require("mini.surround").setup()

        require("mini.extra").setup()
        require("mini.pick").setup()
      end,
      keys = {
        { "<leader>f", "<cmd>Pick files<CR>" },
        { "<leader>m", "<cmd>Pick help<CR>" },
        { "<leader>/", "<cmd>Pick buf_lines<CR>" },
        { "<leader>g", "<cmd>Pick grep_live<CR>" },
        { "<leader>h", "<cmd>Pick git_hunks<CR>" },
        {
          "<leader>n",
          function() require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } }) end,
          desc = "Pick Neovim",
        },
      },
    },
    {
      "mfussenegger/nvim-dap",
      event = "LazyFile",
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mason-org/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        -- Add your own debuggers here
        "leoluz/nvim-dap-go",
      },
      keys = {
        {
          "<F5>",
          function() require("dap").continue() end,
          desc = "Debug: Start/Continue",
        },
        {
          "<F1>",
          function() require("dap").step_into() end,
          desc = "Debug: Step Into",
        },
        {
          "<F2>",
          function() require("dap").step_over() end,
          desc = "Debug: Step Over",
        },
        {
          "<F3>",
          function() require("dap").step_out() end,
          desc = "Debug: Step Out",
        },
        {
          "<leader>b",
          function() require("dap").toggle_breakpoint() end,
          desc = "Debug: Toggle Breakpoint",
        },
        {
          "<leader>B",
          function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
          desc = "Debug: Set Breakpoint",
        },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        {
          "<F7>",
          function() require("dapui").toggle() end,
          desc = "Debug: See last session result.",
        },
      },
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        })

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup({
          icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
          controls = {
            icons = {
              pause = "⏸",
              play = "▶",
              step_into = "⏎",
              step_over = "⏭",
              step_out = "⏮",
              step_back = "b",
              run_last = "▶▶",
              terminate = "⏹",
              disconnect = "⏏",
            },
          },
        })

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- Install golang specific config
        require("dap-go").setup({
          delve = {},
        })
      end,
    },
  },
})

-- General keymaps
vim.keymap.set({ "n", "v", "x" }, ";", ":")
vim.keymap.set({ "n", "v", "x" }, ":", ";")
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "C", [["_C]])
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww 'tw.sh'<CR>")
vim.keymap.set("n", "<leader>sa", "<cmd>vert sf #<CR>", { desc = "Split Alt File" })

vim.keymap.set("n", "<leader>k", function()
  vim.cmd("KodaFetch")
  if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then vim.cmd("lsp restart") end
end, { desc = "Reload Koda" })

vim.keymap.set("n", "<leader>q", function()
  local qf_exists = vim.fn.getqflist({ winid = 0 }).winid ~= 0
  vim.cmd(qf_exists and "cclose" or "copen")
end, { desc = "Quickfix Toggle" })
