return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj
        lookahead = true,
        keymaps = {
          ['af'] = { query = '@function.outer', desc = 'Select around a function (outer)' },
          ['if'] = { query = '@function.inner', desc = 'Select inside a function (inner)' },
          ['ac'] = { query = '@class.outer', desc = 'Select around a class (outer)' },
          ['ic'] = { query = '@class.inner', desc = 'Select inside a class (inner)' },
        },
        include_surrounding_whitespace = true,
      },
    },
  },
}
