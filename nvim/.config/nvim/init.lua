vim.loader.enable()
-- Safest to bootstrap lazy.nvim last
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
require("config.lazy-bootstrap")
