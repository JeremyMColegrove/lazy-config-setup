-- lua/plugins/mini-files.lua
return {
  "echasnovski/mini.files",
  version      = false,
  config       = function()
    require("mini.files").setup({
      mappings = {
        close       = "<leader>`",
        go_in       = "l",
        go_in_plus  = "L",
        go_out      = "h",
        go_out_plus = "H",
        mark_goto   = "'",
        mark_set    = "m",
        reset       = "<BS>",
        reveal_cwd  = "@",
        show_help   = "g?",
        synchronize = "=",
        trim_left   = "<",
        trim_right  = ">",
      },
    })

  end,
  keys = {
    {
      "<leader>`",
      function() 
				  local mf = require("mini.files")
					-- open explorer at the current buffer’s file (second arg=false avoids treating it as a directory)
				mf.open(vim.api.nvim_buf_get_name(0), false)
				-- then jump the cursor to that file’s column
				mf.reveal_cwd()
			end,
      desc = "Open mini.files explorer",
    },
  },
}
