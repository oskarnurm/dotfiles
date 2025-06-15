return {
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
      local gitsigns = require "gitsigns"

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

  -- stylua: ignore start
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Git Preview Hunk' })
      map("n", "<leader>gb", gitsigns.blame_line, { desc = "Git Blame Line" })
      map("n", "<leader>gd", gitsigns.diffthis, { desc = "Git Diff Against Index" })
      map("n", "<leader>gD", function() gitsigns.diffthis "@" end, { desc = "Git Diff Against Last Commit" })
      -- Toggles
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Git Show Blame Line" })
      map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "Toggle Git Show Deleted" })
    end,
  },
}
