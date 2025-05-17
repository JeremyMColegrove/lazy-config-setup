
return {
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",  -- context-aware commentstring
      "nvim-treesitter/nvim-treesitter",             -- TS parsers for AST queries
    },
    config = function()
      require("Comment").setup({
        -- disable default mappings so we can use <leader>c
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
			})
		end,
	},
}
