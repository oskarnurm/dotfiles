local add = vim.pack.add
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

-- now(function() add({ "https://github.com/oskarnurm/koda.nvim" }) end)
-- Benchmark with `=MiniMisc.stat_summary(MiniMisc.bench_time(vim.cmd, 1000, 'colorscheme koda'))`
vim.opt.runtimepath:prepend("~/odin/koda.nvim")
-- require("koda").setup({
--   theme = { dark = "moss", light = "glade" },
--
--   -- on_highlights = function(hl, _)
--   --   if vim.o.background == "light" then
--   --     if hl.Function then hl.Function.bold = true end
--   --   end
--   -- end,
-- })
vim.cmd("colorscheme koda")
vim.keymap.set("n", "<leader>k", "<cmd>KodaFetch<CR>")

now_if_args(function()
  add({ "https://github.com/stevearc/oil.nvim" })
  require("oil").setup({
    view_options = { show_hidden = true },
    skip_confirm_for_simple_edits = true,
  })
  vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
end)

now_if_args(function()
  add({ { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") } })
  require("blink.cmp").setup()
end)

now_if_args(function()
  local ts_update = function() vim.cmd("TSUpdate") end
  Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

  add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  })

  local languages = {
    "bash",
    "c",
    "cpp",
    "diff",
    "html",
    "query",
    "javascript",
    "typescript",
    "tsx",
    "python",
    "json",
    "go",
    "java",
    "rust",
    "comment",
    "markdown",
    "markdown_inline",
    "gitcommit",
    "embedded_template",
    "prisma",
  }
  local not_installed = function(lang) return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0 end
  local to_install = vim.tbl_filter(not_installed, languages)
  if #to_install > 0 then require("nvim-treesitter").install(to_install) end

  -- Ensure Neovim detects .ejs files correctly
  vim.filetype.add({ extension = { ejs = "ejs" } })
  vim.treesitter.language.register("embedded_template", "ejs")

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  Config.autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

  require("nvim-treesitter-textobjects").setup({
    select = {
      lookahead = true,
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "v",
        ["@class.outer"] = "<c-v>",
      },
      include_surrounding_whitespace = false,
    },
  })
end)

now_if_args(function()
  add({ "https://github.com/mason-org/mason.nvim" })
  require("mason").setup()
end)

later(function() add({ "https://github.com/rafamadriz/friendly-snippets" }) end)
later(function() add({ "https://github.com/nvim-lua/plenary.nvim" }) end)
later(function() add({ "https://github.com/tpope/vim-fugitive.git" }) end)

later(function()
  add({ "https://github.com/mbbill/undotree" })
  vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
end)

-- later(function()
--   add({ "https://github.com/dmtrKovalenko/fff.nvim" })
--   -- Config.on_packchanged(
--   --   "fff.nvim",
--   --   { "install", "update" },
--   --   function() require("fff.download").download_or_build_binary() end,
--   --   "Download binary for fff.nvim on change"
--   -- )
--
--   vim.g.fff = {
--     lazy_sync = true,
--     debug = { enabled = true, show_scores = true },
--   }
--   require("fff").setup({ prompt = "> ", layout = { prompt_position = "top" } })
--   vim.keymap.set("n", "<leader>f", function() require("fff").find_files() end, { desc = "Find Files" })
--   vim.keymap.set("n", "<leader>g", function() require("fff").live_grep() end, { desc = "Grep Live" })
-- end)

later(function()
  add({ "https://github.com/folke/which-key.nvim" })
  require("which-key").setup({ preset = "helix", icons = { mappings = false } })
end)

later(function()
  add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
    -- format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
    formatters_by_ft = {
      sh = { "shfmt" },
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      c = { lsp_format = "prefer" },
      -- java = { "google-java-format" },
      java = { lsp_format = "prefer" },
      xml = { "xmlformatter" },
      cpp = { "clang-format" },
      prisma = { "prismals" },
      ["_"] = { "prettierd" },
    },
  })
  vim.keymap.set("n", "<leader>cf", '<cmd>lua require("conform").format()<CR>', { desc = "Format" })
end)

later(function()
  add({ "https://github.com/lewis6991/gitsigns.nvim.git" })
  require("gitsigns").setup({
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  })
  require("gitsigns").setup({
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]h", function() gitsigns.nav_hunk("next") end, { desc = "Next Hunk" })
      map("n", "[h", function() gitsigns.nav_hunk("prev") end, { desc = "Prev Hunk" })

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
      map("n", "ghu", gitsigns.stage_hunk, { desc = "Hunk Undo Stage" })
      map("n", "ghS", gitsigns.stage_buffer, { desc = "Hunk Stage Buffer" })
      map("n", "ghR", gitsigns.reset_buffer, { desc = "Hunk Reset Buffer" })
      map("n", "ghp", gitsigns.preview_hunk, { desc = "Hunk Preview Line" })
      map("n", "ghb", gitsigns.blame_line, { desc = "Hunk Blame Line" })
      map("n", "ghi", gitsigns.diffthis, { desc = "Hunk Diff Index" })
      map("n", "ghc", function() gitsigns.diffthis("@") end, { desc = "Hunk Diff Commit" })
      -- Toggles
      map("n", "ght", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk)
    end,
  })
end)

later(function()
  add({ "https://github.com/Vigemus/iron.nvim.git" })

  local iron = require("iron.core")
  local view = require("iron.view")
  local common = require("iron.fts.common")

  iron.setup({
    config = {
      scratch_repl = true,
      repl_definition = {
        sh = { command = { "zsh" } },
        python = {
          -- command = { "python3" },
          command = { "ipython", "--no-autoindent" },
          format = common.bracketed_paste_python,
          block_dividers = { "# %%", "#%%" },
          env = { PYTHON_BASIC_REPL = "1" },
        },
      },
      repl_filetype = function(bufnr, ft) return ft end,
      dap_integration = true,
      repl_open_cmd = view.split.vertical(),
    },
    keymaps = {
      toggle_repl = "<leader>it",
      restart_repl = "<leader>ir",
      visual_send = "<leader>iv",
      send_file = "<leader>if",
      send_line = "<leader>il",
      send_code_block = "<leader>ib",
      send_code_block_and_move = "<leader>in",
      cr = "<leader>i<cr>",
      interrupt = "<leader>i<space>",
      exit = "<leader>iq",
      clear = "<leader>ic",
    },
    highlight = { italic = true },
    ignore_blank_lines = true,
  })
end)

later(function()
  add({ "https://github.com/chentoast/marks.nvim" })
  require("marks").setup()
end)

later(function()
  add({
    "https://github.com/folke/tokyonight.nvim",
  })
  require("tokyonight").setup({
    -- styles = {
    --   comments = { italic = false },
    --   keywords = { italic = false },
    -- },
  })
end)

-- Better find
vim.cmd([[
func Find(arg, _)
  if empty(s:filescache)
    let s:filescache = systemlist('fd --type f --color=never --follow --hidden --exclude .git')
  endif
  return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
set findfunc=Find

autocmd CmdlineEnter : let s:filescache = []
autocmd CmdlineChanged [:\/\?] call wildtrigger()
autocmd CmdlineLeavePre :
      \ if get(cmdcomplete_info(), 'matches', []) != [] |
      \   let s:info = cmdcomplete_info() |
      \   if getcmdline() =~ '^\s*fin\%[d]\s' && s:info.selected == -1 |
      \     call setcmdline($'find {s:info.matches[0]}') |
      \   endif |
      \ endif
]])

vim.keymap.set("n", "<leader>f", ":find ")
