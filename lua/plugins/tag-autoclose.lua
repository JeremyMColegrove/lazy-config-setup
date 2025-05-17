-- ~/.config/nvim/lua/plugins/autoclose.lua
return {

  -- 1) Auto-close & autorename tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
				opts = {
        enable_close = true,            -- autoclose tags
        enable_rename = true,           -- autorename matching tags
        enable_close_on_slash = false,  -- don’t close on typing `</`
			}
		})
	end,
},

-- 2) Autopairs for brackets/quotes (optional)
{
	"windwp/nvim-autopairs",
	event  = "InsertEnter",
	config = function()
		require("nvim-autopairs").setup({
			check_ts = true,  -- use Tree-sitter to avoid unwanted pairs
			ts_config = {
				javascript = { "template_string" },
				typescript = { "template_string" },
				typescriptreact = { "template_string" },
				html = false,
			},
		})
	end,
},
}
