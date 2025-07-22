return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { sources = { files = { hidden = true } } },
    explorer = {},
    gitbrowse = {},
    indent = { enabled = false },
    toggle = {},
  },
    -- stylua: ignore
    keys = {
    -- Find
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>fi", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>fC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    -- LSP
    { "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
    { "<leader>gD", function() Snacks.picker.lsp_declarations() end, desc = "Declaration" },
    { "<leader>gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "<leader>gI", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
    { "<leader>gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definition" },
    { "<leader>gs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>gS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Other
    { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.diagnostics():map "<leader>td"
        Snacks.toggle.treesitter():map "<leader>tt"
        Snacks.toggle.indent():map "<leader>ti"
      end,
    })
  end,
}
