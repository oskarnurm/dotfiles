return {
  "echasnovski/mini.nvim",
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup()
    require("mini.ai").setup { n_lines = 500 }
    require("mini.icons").setup()

    local hipatterns = require "mini.hipatterns"
    hipatterns.setup {
      highlighters = {
        -- Highlight standalone 'FIX', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
