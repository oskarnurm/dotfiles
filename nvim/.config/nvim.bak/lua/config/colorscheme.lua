-- Monochrome colorsc
vim.cmd 'colorscheme quiet'
vim.api.nvim_set_hl(0, 'Keyword', { fg = '#FFFFFF', bold = true })
vim.api.nvim_set_hl(0, 'Comment', { fg = '#888888', italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = '#999999' })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#000000' })
vim.api.nvim_set_hl(0, 'Visual', { bg = '#71797E', fg = 'NONE' })
