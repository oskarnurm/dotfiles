return {
  "nvim-mini/mini.nvim",
  enabled = false,
  config = function()
    local pick = require("mini.pick")
    require("mini.extra").setup()
    pick.setup({ options = { use_cache = true } })
    -- vim.ui.select = MiniPick.ui_select

    pick.registry.project_files = function(opts)
      local root = vim.fs.root(0, ".git") or vim.uv.cwd()
      return pick.builtin.files(opts, { source = { cwd = root } })
    end

    vim.keymap.set("n", "<leader>sf", "<cmd>Pick files<CR>")
    vim.keymap.set("n", "<leader>sp", "<cmd>Pick project_files<CR>")
    vim.keymap.set("n", "<leader>sb", "<cmd>Pick buffers<CR>")
    vim.keymap.set("n", "<leader>sh", "<cmd>Pick help<CR>")
    vim.keymap.set("n", "<leader>sg", "<cmd>Pick grep_live<CR>")
    vim.keymap.set("n", "<leader>sk", "<cmd>Pick keymaps<CR>")
    vim.keymap.set("n", "<leader>ss", '<cmd>Pick lsp scope="document_symbol"<CR>', { desc = "Pick symbols" })
    vim.keymap.set("n", "<leader>sl", '<cmd>Pick buf_lines scope="current"<CR>', { desc = "Pick buffer" })
    vim.keymap.set("n", "<leader>s;", "<cmd>Pick history<CR>")
    vim.keymap.set("n", "<leader>sr", "<cmd>Pick oldfiles<CR>")
    vim.keymap.set("n", "<leader>sc", "<cmd>Pick colorschemes<CR>")
    vim.keymap.set("n", "<leader>sw", "<cmd>Pick grep pattern='<cword>'<CR>")
    vim.keymap.set("n", "<leader>sn", function()
      pick.builtin.files({}, { source = { cwd = vim.fn.stdpath("config") } })
    end, { desc = "Pick config" })
  end,
}
