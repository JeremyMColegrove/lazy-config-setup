
-- lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",  -- load late, after startup
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup {
      options = {
        icons_enabled   = true,
        theme           = "vscode",    -- match your vscode.nvim theme
        section_separators  = "",      -- no extra separators
        component_separators = "",
        globalstatus    = true,        -- one statusline for the whole window (Neovim 0.8+)
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch",   },
        lualine_c = { "filename" },
        lualine_x = { "encoding" },
        lualine_y = { "progress" },
	lualine_z = { "location" },
      },
      inactive_sections = {
        -- simpler for inactive windows
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "quickfix", "fugitive" },
    }
  end,
}
