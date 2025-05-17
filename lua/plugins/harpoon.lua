return { -- … your other plugins …

  {
    "ThePrimeagen/harpoon",
    -- optional: if you want to tweak its behavior:
    config = function()
      require("harpoon").setup({
        -- e.g. save_on_toggle = true,
        --       enter_on_sendcmd = false,
      })

      local mark = require("harpoon.mark")
      local ui   = require("harpoon.ui")

      -- example keymaps:
      vim.keymap.set("n", "<leader>a", mark.add_file,     { desc = "Harpoon: add file" })
      vim.keymap.set("n", "<leader>m", ui.toggle_quick_menu, { desc = "Harpoon: menu" })
      vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon: go to file 1" })
      vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon: go to file 2" })
      vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon: go to file 3" })
      vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon: go to file 4" })
      vim.keymap.set("n", "<leader>ca", mark.clear_all, { desc = "Harpoon: clear all marks" })
    end,
  },

  -- … more plugins …
}
