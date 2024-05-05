return {
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
      require("trouble").setup {
        icons = false,
      }
      vim.keymap.set("n", "<leader>xx", function()
        require("trouble").toggle()
      end, { desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>xw", function()
        require("trouble").toggle "workspace_diagnostics"
      end, { desc = "Workspace Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xd", function()
        require("trouble").toggle "document_diagnostics"
      end, { desc = "Document Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xq", function()
        require("trouble").toggle "quickfix"
      end, { desc = "Quickfix List (Trouble)" })
      vim.keymap.set("n", "<leader>xl", function()
        require("trouble").toggle "loclist"
      end, { desc = "Location List (Trouble)" })
      vim.keymap.set("n", "gR", function()
        require("trouble").toggle "lsp_references"
      end, { desc = "LSP References (Trouble)" })
    end,
  },
}
