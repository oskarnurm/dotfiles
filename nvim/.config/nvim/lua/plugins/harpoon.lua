-- stylua: ignore
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = function()
    local keys = {
      { "<leader>h", function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
      { "<leader>H", function() require("harpoon"):list():add() end, desc = "Harpoon File", },
      { "<leader>j", function() require("harpoon"):list():select(1) end, desc = "Harpoon to File 1", },
      { "<leader>k", function() require("harpoon"):list():select(2) end, desc = "Harpoon to File 2", },
      { "<leader>l", function() require("harpoon"):list():select(3) end, desc = "Harpoon to File 3", },
      { "<leader>;", function() require("harpoon"):list():select(4) end, desc = "Harpoon to File 4", },
    }
    return keys
  end,
}
