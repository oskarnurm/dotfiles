-- download prebuild binary or build from source
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    if event.data.updated then require("fff.download").download_or_build_binary() end
  end,
})
