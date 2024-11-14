return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = 'VimEnter',
  config = true,
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "[t]odo (Trouble)" },
    { "<leader>tT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "[T]odo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[t]odo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "[T]odo/Fix/Fixme" },

  },
}
