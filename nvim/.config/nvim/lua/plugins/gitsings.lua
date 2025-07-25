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
        -- Visual
        map("v", "<leader>hs", function() gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, { desc = "Stage hunk" })
        map("v", "<leader>hr", function() gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, { desc = "Reset hunk" })
        -- Normal
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", gitsigns.blame_line, { desc = "Blame Line" })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Blame Line" })
    end,
  },
}
