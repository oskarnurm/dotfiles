vim.diagnostic.config({ virtual_text = true, underline = false })
-- vim.lsp.document_color.enable(true, 0, { style = "virtual" })

-- Dynamic LPS enabling
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    map("<leader>gr", "<cmd>FzfLua lsp_references<CR>", "Goto References")
    map("<leader>ga", "<cmd>FzfLua lsp_code_actions<CR>", "Code Action", { "n", "x" })
    map("<leader>gi", "<cmd>FzfLua lsp_implementations<CR>", "Goto Implementation")
    map("<leader>gD", "<cmd>FzfLua lsp_definitions jump=true<CR>", "Goto Definition")
    map("<leader>gd", "<cmd>FzfLua lsp_definitions jump1=false<CR>", "Peek Definition")
    -- map("<leader>gD", "<cmd>FzfLua lsp_declarations<CR>", "Goto Declaration")
    map("<leader>gs", "<cmd>FzfLua lsp_document_symbols<CR>", "Document Symbols")
    map("<leader>gW", "<cmd>FzfLua lsp_workspace_symbols<CR>", "Workspace Symbols")
    map("<leader>gt", "<cmd>FzfLua lsp_typedefs<CR>", "Goto Type Definition")
    map("<leader>td", function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, "Diagnostics")
  end,
})
