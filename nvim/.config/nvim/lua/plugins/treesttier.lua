return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = "LazyFile",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
    auto_install = true,
    highlight = {
      enable = true,
      -- Disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "zi",
        node_incremental = "zi",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer" },
          ["if"] = { query = "@function.inner" },
          ["ac"] = { query = "@conditional.outer" },
          ["ic"] = { query = "@conditional.inner" },
          ["al"] = { query = "@loop.outer" },
          ["il"] = { query = "@loop.inner" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
        },
        include_surrounding_whitespace = true,
      },
    },
  },
}
