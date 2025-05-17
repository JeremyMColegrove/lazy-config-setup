-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
	  local actions = require("telescope.actions")
	local builtin = require('telescope.builtin')
	local telescope = require("telescope")
	
	telescope.setup {
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
				},
				n = {
					["<esc>"] = actions.close,
				}
			}
		}
	}
	vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Telescope live grep' })
  end
}
