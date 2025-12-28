return {
  "ibhagwan/fzf-lua",
  enabled = false,
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup()
    fzf.register_ui_select()
    -- fzf.register_ui_input()
    -- vim.keymap.set("n", "<leader>sf", "<cmd>FzfLua files<CR>", { desc = "Files" })
    vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
    vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua help_tags<CR>", { desc = "Help" })
    vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "Grep" })
    vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<CR>", { desc = "Keymaps" })
    vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Symbols" })
    vim.keymap.set("n", "<leader>/", "<cmd>FzfLua blines<CR>", { desc = "Search Buffer" })
    vim.keymap.set("n", "<leader>sr", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent" })
    vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<CR>", { desc = "cWord" })
    vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua colorschemes<CR>", { desc = "Colorschemes" })
    vim.keymap.set("n", "<leader>sn", function()
      fzf.files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Neovim" })
  end,
}
