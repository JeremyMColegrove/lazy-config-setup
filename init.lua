-- leader, tab settings, etc.
vim.g.mapleader = " "
vim.opt.termguicolors  = true
vim.opt.shiftwidth     = 2
vim.opt.tabstop        = 2
vim.opt.relativenumber = true
vim.opt.showmode       = false
vim.opt.clipboard      = "unnamedplus"

-- keep your scrolling centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true })

-- other mappings
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", ":Prettier<CR>", { desc = "Format with Prettier" })
vim.keymap.set("v", "<M-c>", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>q", "gcc", { desc = "Toggles code comment", remap = true, silent = true})
vim.keymap.set("v", "<leader>q", "gc", { desc = "Toggle code comment in visual mode", remap = true, silent = true})

require("config.lazy")
