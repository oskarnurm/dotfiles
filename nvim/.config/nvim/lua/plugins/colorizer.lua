-- Hightlights color codes in the editor like this: #fff
return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end,
}
