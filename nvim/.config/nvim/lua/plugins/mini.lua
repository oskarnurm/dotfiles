return {
  'echasnovski/mini.nvim',
  event = 'VeryLazy',
  config = function()
    require('mini.surround').setup()
    require('mini.ai').setup { n_lines = 500 }
    -- require('mini.files').setup {
    --   mappings = {
    --     close = '<esc>',
    --     go_in = '<right>',
    --     go_in_plus = '<CR>',
    --     go_out = 'H',
    --     go_out_plus = '<left>',
    --     reset = '<BS>',
    --     reveal_cwd = '.',
    --     show_help = '?',
    --     synchronize = 's',
    --     trim_left = '<',
    --     trim_right = '>',
    --   },
    --   windows = {
    --     preview = true,
    --     width_focus = 30,
    --     width_preview = 80,
    --   },
    -- }
    -- vim.keymap.set('n', '<leader>o', '<cmd>lua MiniFiles.open()<cr>', { desc = '[O]pen Files' })

    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        -- Highlight standalone 'FIX', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIX()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
