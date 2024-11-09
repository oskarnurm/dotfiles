-- Colorscheme
return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  init = function()
    -- Load the colorscheme here.
    vim.cmd.colorscheme 'gruvbox'
  end,
}
