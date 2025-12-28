return {
  "lewis6991/gitsigns.nvim",
  event = "LazyFile",
  opts = {
    signs = {
      add = { text = "+" },
      change = { text = "~" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "]h", function()
        gs.nav_hunk("next")
      end, { desc = "Next Hunk" })
      map("n", "[h", function()
        gs.nav_hunk("prev")
      end, { desc = "Previous Hunk" })

      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset hunk" })

      map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
      map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hb", gs.blame_line, { desc = "Blame Line" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Blame Line" })
      map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Hunk" })
    end,
  },
}
