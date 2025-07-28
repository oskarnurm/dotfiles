vim.loader.enable()
-- Bootstrap lazy.nvim last so that all of our core settings
-- are applied before any plugins are loaded
require "config.options"
require "config.keymaps"
require "config.autocmd"
require "config.lazy"
