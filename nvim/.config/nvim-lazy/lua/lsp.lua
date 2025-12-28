vim.diagnostic.config({ virtual_text = true, underline = false })
-- vim.lsp.document_color.enable(true, 0, { style = "virtual" })

-- Dynamic LPS enabling
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        local server_configs = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
            :map(function(file)
                return vim.fn.fnamemodify(file, ":t:r")
            end)
            :totable()
        vim.lsp.enable(server_configs)
    end,
})

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()" })
vim.keymap.set("n", "grO", vim.lsp.buf.document_symbol, { desc = "vim.lsp.buf.document_symbol()" })
