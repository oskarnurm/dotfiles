vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    vim.lsp.document_color.enable(true, 0, { style = "virtual" })

    map("K", vim.lsp.buf.hover, "Hover")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
    map("grr", vim.lsp.buf.references, "Goto References")
    map("gri", vim.lsp.buf.implementation, "Goto Implementation")
    map("grd", vim.lsp.buf.definition, "Goto Definition")
    map("grD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gO", vim.lsp.buf.document_symbol, "Document Symbols")
    map("gW", vim.lsp.buf.workspace_symbol, "Workspace Symbols")
    map("grt", vim.lsp.buf.type_definition, "Goto Type Definition")
    map("<leader>td", function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, "Diagnostics")
  end,
})
