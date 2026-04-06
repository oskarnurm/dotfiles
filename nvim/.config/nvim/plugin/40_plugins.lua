local add = vim.pack.add
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

vim.opt.runtimepath:prepend("~/odin/koda.nvim")
-- Benchmark with `=MiniMisc.stat_summary(MiniMisc.bench_time(vim.cmd, 1000, 'colorscheme koda'))`
vim.cmd.colorscheme("koda")
require("koda").setup()

now(function()
  require("mini.icons").setup({})
  later(MiniIcons.tweak_lsp_kind) -- Add LSP kind icons. Useful for 'mini.completion'.
end)

now_if_args(function()
  add({ "https://github.com/stevearc/oil.nvim" })
  require("oil").setup({ view_options = { show_hidden = true } })
  vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
end)

-- now_if_args(function()
--   add({ { src = "https://github.com/saghen/blink.cmp.git", version = vim.version.range("*") } })
--   require("blink.cmp").setup()
-- end)

now_if_args(function()
  -- Don't show 'Text' suggestios and prioritize snippets
  local opts = { kind_priority = { Snippet = 99 } }
  local process_items = function(items, base) return MiniCompletion.default_process_items(items, base, opts) end
  require("mini.completion").setup({
    lsp_completion = {
      source_func = "omnifunc",
      auto_setup = false, -- enable it lazily below
      process_items = process_items,
    },
  })

  -- Set 'omnifunc' for LSP completion only when needed.
  local on_attach = function(ev) vim.bo[ev.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp" end
  Config.autocmd("LspAttach", nil, on_attach, "Set 'omnifunc'")

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

now_if_args(function()
  local ts_update = function() vim.cmd("TSUpdate") end
  Config.on_packchanged("nvim-treesitter", { "update" }, ts_update, ":TSUpdate")

  add({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  })

  local languages = {
    -- To see available languages: `:=require('nvim-treesitter').get_available()`
    -- - Visit 'SUPPORTED_LANGUAGES.md' file at
    --   https://github.com/nvim-treesitter/nvim-treesitter/blob/main
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

later(function() require("mini.extra").setup() end)

-- Example usage:
-- - `ci)` - *c*hange *i*inside parenthesis (`)`)
-- - `di(` - *d*elete *i*inside padded parenthesis (`(`)
-- - `yaq` - *y*ank *a*round *q*uote (any of "", '', or ``)
-- - `vif` - *v*isually select *i*inside *f*unction call
-- - `cina` - *c*hange *i*nside *n*ext *a*rgument
later(function()
  local ai = require("mini.ai")
  ai.setup({
    custom_textobjects = {
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      o = ai.gen_spec.treesitter({
        a = { "@conditional.outer", "@loop.outer" },
        i = { "@conditional.inner", "@loop.inner" },
      }),
    },
  })
end)

later(function()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({ highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() } })
end)

-- Example usage:
-- - `cii` - *c*hange *i*nside *i*ndent scope
-- - `Vaiai` - *V*isually select *a*round *i*ndent scope and then again
--   reselect *a*round new *i*indent scope
-- - `[i` / `]i` - navigate to scope's top / bottom
-- later(function() require("mini.indentscope").setup() end)

later(function()
  require("mini.pick").setup()
  vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>", { desc = "Pick Files" })
  vim.keymap.set("n", "<leader>m", "<cmd>Pick help<CR>", { desc = "Pick Manual" })
  vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines<CR>", { desc = "Pick Lines" })
  vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>", { desc = "Pick Grep" })
  vim.keymap.set("n", "<leader>h", "<cmd>Pick git_hunks<CR>", { desc = "Pick Hunks" })
  vim.keymap.set("n", "<leader>ss", "<cmd>Pick lsp scope='document_symbol'<CR>", { desc = "Pick Symbols" })
  vim.keymap.set("n", "<leader>sd", "<cmd>Pick diagnostic scope='current'<CR>", { desc = "Pick Diagnostics" })
  vim.keymap.set("n", "<leader>sD", "<cmd>Pick diagnostic scope='all'<CR>", { desc = "Pick Diagnostics All" })
  vim.keymap.set(
    "n",
    "<leader>n",
    function() require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } }) end,
    { desc = "Pick Neovim" }
  )
end)

-- Example usage (this may feel intimidating at first, but after practice it
-- becomes second nature during text editing):
-- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
-- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
-- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
-- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
-- - `shf`   - *s*urround *h*ighlight current *f*unction call
-- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
-- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
later(function() require("mini.surround").setup() end)
later(function() require("mini.pairs").setup({ modes = { command = true } }) end)
later(function() require("mini.misc").setup() end)

later(function()
  local snippets = require("mini.snippets")
  -- Load snippets based on current language by reading files from
  -- "snippets/" subdirectories from 'runtimepath' directories.
  snippets.setup({ snippets = { snippets.gen_loader.from_lang() } })

  -- Enable snippets
  -- Empty tabstops are visualized with inline virtual text (“•”/“∎” for regular/final tabstops)
  -- Jump to next with <C-l>
  -- Jump back with <C-h>
  -- Use <C-n> / <C-p> to select next / previous item.
  -- Stop session with <C-c>
  MiniSnippets.start_lsp_server()

  -- Stop all sessions on Normal mode exit
  local make_stop = function()
    local au_opts = { pattern = "*:n", once = true }
    au_opts.callback = function()
      while MiniSnippets.session.get() do
        MiniSnippets.session.stop()
      end
    end
    vim.api.nvim_create_autocmd("ModeChanged", au_opts)
  end
  local opts = { pattern = "MiniSnippetsSessionStart", callback = make_stop }
  vim.api.nvim_create_autocmd("User", opts)
end)

later(function() add({ "https://github.com/rafamadriz/friendly-snippets" }) end)

later(function()
  add({ "https://github.com/folke/which-key.nvim" })
  require("which-key").setup({ preset = "helix", icons = { mappings = false } })
end)

later(function()
  add({ "https://github.com/mbbill/undotree" })
  vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")
end)

later(function()
  add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
    format_on_save = { lsp_format = "fallback", timeout_ms = 1000 },
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
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk)
    end,
  })
end)

later(function() add({ "https://github.com/tpope/vim-fugitive.git" }) end)
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
      toggle_repl = "<leader>rt",
      restart_repl = "<leader>rr",
      visual_send = "<leader>rv",
      send_file = "<leader>rf",
      send_line = "<leader>rl",
      send_code_block = "<leader>rb",
      send_code_block_and_move = "<leader>rn",
      cr = "<leader>r<cr>",
      interrupt = "<leader>r<space>",
      exit = "<leader>rq",
      clear = "<leader>rc",
    },
    highlight = { italic = true },
    ignore_blank_lines = true,
  })
end)
