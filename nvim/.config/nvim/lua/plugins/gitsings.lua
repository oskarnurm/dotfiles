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
      end, { desc = "Previous Hunk" })

      -- Visual
      map("v", "<leader>hs", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })
      map("v", "<leader>hr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset hunk" })

      -- Normal
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "Undo Stage Hunk" })
      map("n", "<leader>hb", gitsigns.blame_line, { desc = "Blame Line" })
      map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Blame Line" })

      -- Text object
      map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Hunk" })
    end,
  },
}
