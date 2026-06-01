local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

now(function()
  require("mini.icons").setup({})
  later(MiniIcons.tweak_lsp_kind) -- Add LSP kind icons. Useful for 'mini.completion'.
end)

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

-- Example usage:
-- - `saiw)` - *s*urround *a*dd for *i*nside *w*ord parenthesis (`)`)
-- - `sdf`   - *s*urround *d*elete *f*unction call (like `f(var)` -> `var`)
-- - `srb[`  - *s*urround *r*eplace *b*racket (any of [], (), {}) with padded `[`
-- - `sf*`   - *s*urround *f*ind right part of `*` pair (like bold in markdown)
-- - `shf`   - *s*urround *h*ighlight current *f*unction call
-- - `srn{{` - *s*urround *r*eplace *n*ext curly bracket `{` with padded `{`
-- - `sdl'`  - *s*urround *d*elete *l*ast quote pair (`'`)
later(function() require("mini.surround").setup() end)

later(function() require("mini.extra").setup() end)
later(function() require("mini.misc").setup() end)
later(function() require("mini.jump2d").setup() end)

-- later(function()
--   require("mini.pick").setup()
--   -- vim.keymap.set("n", "<leader>f", "<cmd>Pick files<CR>", { desc = "Pick Files" })
--   vim.keymap.set("n", "<leader>m", "<cmd>Pick help<CR>", { desc = "Pick Manual" })
--   vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines<CR>", { desc = "Pick Lines" })
--   vim.keymap.set("n", "<leader>g", "<cmd>Pick grep_live<CR>", { desc = "Pick Grep" })
--   vim.keymap.set("n", "<leader>h", "<cmd>Pick git_hunks<CR>", { desc = "Pick Hunks" })
--   vim.keymap.set("n", "<leader>cs", "<cmd>Pick colorschemes<CR>", { desc = "Pick Colorschemes" })
--   vim.keymap.set("n", "<leader>r", "<cmd>Pick resume<CR>", { desc = "Pick Resume" })
--   vim.keymap.set("n", "<leader>ss", "<cmd>Pick lsp scope='document_symbol'<CR>", { desc = "Pick Symbols" })
--   vim.keymap.set("n", "<leader>sd", "<cmd>Pick diagnostic scope='current'<CR>", { desc = "Pick Diagnostics" })
--   vim.keymap.set("n", "<leader>sD", "<cmd>Pick diagnostic scope='all'<CR>", { desc = "Pick Diagnostics All" })
--   vim.keymap.set(
--     "n",
--     "<leader>n",
--     function() require("mini.pick").builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } }) end,
--     { desc = "Pick Neovim" }
--   )
-- end)
