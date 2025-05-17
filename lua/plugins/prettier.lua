return {
{
  "prettier/vim-prettier",
  build = "npm install --force", -- required!
  ft = { "javascript", "typescript", "typescriptreact", "json", "css", "html", "markdown", "yaml" },
  config = function()
    -- Optional: enable auto format on save here or globally
    vim.g["prettier#autoformat"] = 0
    vim.g["prettier#autoformat_require_pragma"] = 0
  end,
}
}
